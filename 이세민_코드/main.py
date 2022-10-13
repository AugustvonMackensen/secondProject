# -*- encoding: utf-8 -*-

import time
import cv2
import imutils
import platform
import numpy as np
from threading import Thread
from queue import Queue


# Python에는 Thread를 사용하면 성능을 향상할 수 있으며,
# 처리된 데이터를 유실없이 처리하기 위해 Queue 사용함
# 즉, 한 개의 쓰래드를 순차적으로 실행하다 보면,
# 무거운 OpenCV 실행시 성능의 저하를 가져옴

class Streamer:

    def __init__(self):
        # 초기 선언 : 생성자

        # 현재 컴퓨터가 OpenCL을 지원하는지 체크함
        if cv2.ocl.haveOpenCL():
            # CPU보다 OpenCL 을 사용하면 성능이 향상됨
            cv2.ocl.setUseOpenCL(True)
        print('[webBindCV] ', 'OpenCL : ', cv2.ocl.haveOpenCL())

        self.capture = None
        self.thread = None
        self.width = 640
        self.height = 360
        self.stat = False
        self.current_time = time.time()
        self.preview_time = time.time()
        self.sec = 0
        self.Q = Queue(maxsize=128)
        self.started = False

    def run(self, src=0):
        # 카메라 시작
        self.stop()

        if platform.system() == 'Windows':
            self.capture = cv2.VideoCapture(src, cv2.CAP_DSHOW)

        else:
            self.capture = cv2.VideoCapture(src)

        self.capture.set(cv2.CAP_PROP_FRAME_WIDTH, self.width)
        self.capture.set(cv2.CAP_PROP_FRAME_HEIGHT, self.height)

        if self.thread is None:
            self.thread = Thread(target=self.update, args=())
            self.thread.daemon = False
            self.thread.start()

        self.started = True

    def stop(self):
        # 카메라 정지
        self.started = False

        if self.capture is not None:
            self.capture.release()
            self.clear()

    def update(self):
        # 영상 실시간 처리 : 웹캠이 켜지고 지속적인 프레임을 추출함
        while True:
            if self.started:
                (grabbed, frame) = self.capture.read()

                if grabbed:
                    self.Q.put(frame)

    def clear(self):
        # 영상 데이터 삭제
        with self.Q.mutex:
            self.Q.queue.clear()

    def read(self):
        # 영상 데이터 읽기
        return self.Q.get()

    def blank(self):
        # 영상 데이터 부재시 검은 화면 출력
        return np.ones(shape=[self.height, self.width, 3], dtype=np.uint8)

    def bytescode(self):
        # 영상을 바이너리 코드로 전환
        if not self.capture.isOpened():
            frame = self.blank()

        else:
            frame = imutils.resize(self.read(), width=int(self.width))

            if self.stat:
                cv2.rectangle(frame, (0, 0), (120, 30), (0, 0, 0), -1)
                fps = 'FPS : ' + str(self.fps())
                cv2.putText(frame, fps, (10, 20), cv2.FONT_HERSHEY_PLAIN, 1, (0, 0, 255), 1, cv2.LINE_AA)

        return cv2.imencode('.jpg', frame)[1].tobytes()

    def fps(self):
        # 영상 FPS 처리
        self.current_time = time.time()
        self.sec = self.current_time - self.preview_time
        self.preview_time = self.current_time

        if self.sec > 0:
            fps = round(1 / (self.sec), 1)

        else:
            fps = 1

        return fps

    def __exit__(self):
        # 클래스 종료
        print('* streamer class exit')
        self.capture.release()
# =================================================

# -*- encoding: utf-8 -*-
# 윈도우창이 아닌 웹브라웅저를 통해 카메라 영상을 출력하는 방법으로
# IP 카메라와 비슷한 원리로 작동하는 방법으로 처리

# pip install --upgrade pip
# pip install cython

# 만약 OpenCV를 설치하지 않았다면,
# “numpy”의 경우는 pip를 통해 OpenCV 설치시 오류가 발생할 가능성이 있으므로,
# 17 버전 미만으로 설치하기 바람.

# pip install "numpy<17"
# pip install imutils
# pip install flask
# pip install opencv-python
# pip install opencv-contrib-python

from flask import Flask
from flask import request
from flask import Response
from flask import stream_with_context
# request는 웹에서 GET, POST 메소드를 사용하여,
# 전송된 파라미터의 값을 받는 것에 사용합니다.

# Response는 페이지 데이터 혹은 콘텐츠를 출력할 때 사용하며,
# html, text 등 다양한 웹콘텐츠를 출력할 수 있습니다.

# stream_with_context 는 url로 호출시,
# 접속이 timeout 되는 것과 관계 없이 호출한 내용을 유지시켜
# 지속적으로 데이터를 전송시켜 주는 역할을 합니다.

# from streamer import Streamer

app = Flask(__name__)
# Flask class의 __name__ 는 현재 패키지의 경로를 인식하는 인자입니다.

# Flask Server Streaming 모듈 사용
streamer = Streamer()  # Streamer 의 __init__(self) 실행됨


@app.route('/stream')
def stream():
    src = request.args.get('src', default=0, type=int)
    # 브라우저에서 접속 요청 :
    # http://서버ip주소:포트번호/stream?src=카메라번호
    try:
        # 클라이언트로 응답 처리 : 영상을 보냄
        # 웹브라우저로 Streaming 으로 전달하기 위해
        # Response Header 의 mimetype 을 지정함
        return Response(stream_with_context(stream_gen(src)),
                        mimetype='multipart/x-mixed-replace; boundary=frame')

    except Exception as e:
        print('[webBindCV] ', 'stream error : ', str(e))


def stream_gen(src):
    # 카메라 작동
    try:
        streamer.run(src)

        while True:
            # 영상을 jpeg로 인코딩하여 yield 로 호출한 url로
            # 실시간 바이너리를 전송하게 됨
            frame = streamer.bytescode()
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

    except GeneratorExit:
        print('[webBindCV]', 'disconnected stream')
        streamer.stop()

# =======================================================


# OpenCV 영상 웹브라우저에 띄우기 샘플 Python 스크립트입니다.
# encoding : utf-8



import sys
# from test.cv.server import app

# 스트리밍 서버를 구동시킴.
if __name__ == '__main__':
    print('------------------------------------------------')
    print('웹브라우저와 CV 카메라 영상 연동 테스트')
    print('------------------------------------------------')

    if len(sys.argv) != 2:
        app.run(host='0.0.0.0', port=5000)
    else:
        client_ip = sys.argv[1]
        app.run(host=client_ip, port=5000)


