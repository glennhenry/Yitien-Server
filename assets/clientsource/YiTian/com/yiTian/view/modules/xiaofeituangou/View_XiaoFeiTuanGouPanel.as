package com.yiTian.view.modules.xiaofeituangou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.activityGuide.ActivityGuideVo;
   import com.yiTian.view.modules.activityGuide.View_ActivityGuidePanel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class View_XiaoFeiTuanGouPanel extends Panel123
   {
      
      private static var _instance:View_XiaoFeiTuanGouPanel;
      
      private var _maxPage:int = 0;
      
      private var _len:int = 5;
      
      private var _pageLen:int = 3;
      
      private var _rightButton:Button;
      
      private var _leftButton:Button;
      
      private var _pageTF:MyTextField;
      
      private var _curPage:int = 0;
      
      private var _itemVec:Vector.<TuanGouXiaoFei_Item> = new Vector.<TuanGouXiaoFei_Item>();
      
      private var _init:Boolean = false;
      
      private var _itemDic:Dictionary = new Dictionary();
      
      private var _voArr:Array;
      
      private var _closeBtn:Button;
      
      private var _dateTF:MyTextField;
      
      public function View_XiaoFeiTuanGouPanel()
      {
         super();
         regResource("lang/ch/XiaoFeiTuanGou.swf","XFTGdm");
      }
      
      public static function get instance() : View_XiaoFeiTuanGouPanel
      {
         if(!_instance)
         {
            _instance = new View_XiaoFeiTuanGouPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var item:TuanGouXiaoFei_Item = null;
         move = new Rectangle(0,0,777,40);
         this._len = Data_lib.xiaofeituangou.getLength();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":777,
            "height":467
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":727,
            "height":417
         },Global.Img_Cdm);
         this._closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":742,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_KFTG",this,{
            "x":308,
            "y":5
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_RenWu",this,{
            "x":-185,
            "y":50
         },Global.XFTGdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":127,
            "y":52,
            "width":613,
            "height":371
         },Global.XFTGdm);
         this._dateTF = ComponentUtil.getTextField("活动时间:05月22日00:00至05月30日23:59",this,{
            "x":65,
            "y":429,
            "color":13684779,
            "size":12,
            "leading":0
         });
         this._dateTF.align = TextFormatAlign.LEFT;
         ComponentUtil.getTextField("注：跨服数据每半小时更新一次",this,{
            "x":570,
            "y":429,
            "color":16646144,
            "size":12,
            "leading":0
         });
         this._rightButton = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":467,
            "y":429,
            "textColor":16771436,
            "name":"right"
         },Global.Img_Cdm);
         this._leftButton = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":387,
            "y":429,
            "textColor":16771436,
            "name":"left"
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,1,1],this,{
            "x":408,
            "y":430,
            "width":58,
            "height":18
         },Global.Img_Cdm);
         this._pageTF = ComponentUtil.getTextField("0/0",this,{
            "x":408,
            "y":430,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":58
         });
         this._pageTF.align = TextFormatAlign.CENTER;
         this._rightButton.callBack = this._leftButton.callBack = this.updateListButton;
         i = 0;
         while(i < this._len)
         {
            item = new TuanGouXiaoFei_Item();
            addChild(item);
            this._itemVec.push(item);
            this._itemDic[i] = item;
            item.x = 133;
            item.y = i * 120 + 58;
            i++;
         }
         this._init = true;
         this.setCurrentPage(0);
      }
      
      private function updateListButton(e:MouseEvent) : void
      {
         switch(e.target.name)
         {
            case "left":
               --this._curPage;
               if(this._curPage <= 0)
               {
                  this._curPage = 0;
               }
               break;
            case "right":
               ++this._curPage;
               if(this._curPage >= this._maxPage)
               {
                  this._curPage = this._maxPage;
               }
         }
         this.setCurrentPage(this._curPage);
      }
      
      private function setCurrentPage(pageIndex:int) : void
      {
         this.computeMaxPage();
         this._curPage = Math.max(0,Math.min(pageIndex,this._maxPage));
         this.showPage();
      }
      
      private function computeMaxPage() : void
      {
         if(this._len % 3 == 0)
         {
            this._maxPage = int(this._len / this._pageLen) - 1;
         }
         else
         {
            this._maxPage = int(this._len / this._pageLen);
         }
         this._pageTF.text = this._curPage + 1 + "/" + (this._maxPage + 1);
      }
      
      private function showPage() : void
      {
         var len2:int = this._itemVec.length - 1;
         var i:int = len2;
         while(i >= 0)
         {
            if(Boolean(this._itemVec[i]))
            {
               removeChild(this._itemVec[i]);
               this._itemVec.pop();
            }
            i--;
         }
         var count:int = 0;
         var idIndex:int = this._curPage * this._pageLen;
         while(count < 3)
         {
            if(this._itemDic[idIndex] == null)
            {
               count = 3;
               break;
            }
            addChild(this._itemDic[idIndex]);
            this._itemVec.push(this._itemDic[idIndex]);
            this._itemDic[idIndex].x = 133;
            this._itemDic[idIndex].y = count * 120 + 58;
            count++;
            idIndex++;
         }
         if(Boolean(this._voArr) && Boolean(this._voArr.length))
         {
            this.update(this._voArr);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function update(voArr:Array) : void
      {
         var str:String = null;
         var idx:int = 0;
         this._voArr = voArr;
         if(!this._init)
         {
            return;
         }
         var vo:ActivityGuideVo = View_ActivityGuidePanel.instance.getData();
         if(Boolean(vo))
         {
            str = vo.time;
            this._dateTF.htmlText = str;
         }
         var i:int = 0;
         while(i < this._itemVec.length)
         {
            idx = i + this._curPage * this._pageLen;
            this._itemVec[i].update(this._voArr[idx]);
            i++;
         }
         this.updateTuanGou();
      }
      
      public function getAward() : void
      {
         var i:int = TuanGouVo.BTN_INDEX - 1 - this._curPage * this._pageLen;
         if(Boolean(this._itemVec[i]))
         {
            this._itemVec[i].getAward();
         }
      }
      
      public function updateTuanGou() : void
      {
         var i:int = 0;
         var idx:int = 0;
         var num:int = 0;
         if(!this._init || !this._voArr || !this._voArr.length)
         {
            return;
         }
         if(Boolean(TuanGouVo.tuanGouNum.length))
         {
            i = 0;
            while(i < this._itemVec.length)
            {
               idx = i + this._curPage * this._pageLen;
               num = int(TuanGouVo.tuanGouNum[idx]);
               this._itemVec[i].updateTuanGou(num);
               i++;
            }
         }
      }
      
      public function close(close:int) : void
      {
         var idx:int = 0;
         var type:int = 0;
         TuanGouVo.RESET_VALUE = close;
         if(this._init)
         {
            return;
         }
         var i:int = 0;
         while(i < this._itemVec.length)
         {
            idx = i + this._curPage * this._pageLen;
            type = int(Data_lib.xiaofeituangou[idx + 1][0]);
            if(type == 5)
            {
               this._itemVec[i].close(close);
            }
            i++;
         }
      }
   }
}

