document.readyState === 'complete' ? init() : window.onload = init;
//
function init() {

      // 숫자 선택
    let theComboNumber = new wijmo.input.ComboBox('#theComboNumber', {
        selectedIndexChanged: sender => {
            setText('theNumber', sender.selectedItem);
        },
        itemsSource: [1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018],
    });
  
  //날짜 선택
  let theComboDate = new wijmo.input.ComboBox('#theComboDate', {
        selectedIndexChanged: sender => {
            setText('theDate', wijmo.Globalize.format(sender.selectedItem, 'd'));
        },
    //월의 기본값은 0부터 시작
        itemsSource: [new Date(2000,4,26), new Date(2001,4,26), new Date(2002,4,26), new Date(2003,4,26), new Date(2004,4,26), new Date(2005,4,26)],
        formatItem: (sender, e) => {
            e.item.textContent = wijmo.Globalize.format(e.data, 'yyyy');
        },
    });
  
  
   function setText(id, value) {
        document.getElementById(id).textContent = value;
    }
}







<div class="container-fluid">
        <div class="form-group">
            <label>
               연도를 선택하세요:
                <div id="theComboNumber"></div>
            </label>
        </div>
        <p>
            선택한 연도는 <b id="theNumber"> </b>년입니다.
        </p>

        <hr />
    
          <div class="form-group">
            <label>
                날짜를 선택하세요:
                <div id="theComboDate"></div>
            </label>
        </div>
        <p>
            선택한 날짜는 <b id="theDate"></b> 입니다.
        </p>
 
    </div>