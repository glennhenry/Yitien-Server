package com.yiTian.view.modules.guaji
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class Child_lqqdListItem extends Sprite
   {
      
      private var tf_id:MyTextField;
      
      private var tf_bangName:MyTextField;
      
      private var tf_roleName:MyTextField;
      
      private var btn_preview:Button;
      
      private var btn_qiangduo:Button;
      
      private var _info:Object;
      
      public var _rId:int;
      
      public function Child_lqqdListItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":28,
            "width":281,
            "height":2
         },Global.Img_Cdm);
         this.tf_id = ComponentUtil.getTextField("00",this,{
            "x":8,
            "y":6,
            "color":16773818,
            "size":12
         });
         this.tf_roleName = ComponentUtil.getTextField("",this,{
            "x":86,
            "y":6,
            "color":16773818,
            "realWidth":0
         });
         this.tf_roleName.autoSize = TextFieldAutoSize.CENTER;
         this.tf_roleName.mouseEnabled = true;
         this.tf_roleName.addEventListener(TextEvent.LINK,this.previewClickHandle);
         this.tf_bangName = ComponentUtil.getTextField("",this,{
            "x":172,
            "y":6,
            "color":16773818,
            "realWidth":0
         });
         this.tf_bangName.autoSize = TextFieldAutoSize.CENTER;
         this.btn_qiangduo = ComponentUtil.getButton("","Mission_Two",this,{
            "x":224,
            "y":4,
            "textColor":16773818
         },Global.Img_Cdm);
         this._info = new Object();
         this.btn_qiangduo.callBack = this.qiangDuoClickHandle;
      }
      
      public function setInfo(array:Array, index:int) : void
      {
         var str1:String = null;
         var pip:View_lqqdPlayerInfoPanel = UIManager.lqqdPlayerInfoPanel;
         this._rId = (pip.currentIndex - 1) * 5 + index;
         if(array == null)
         {
            str1 = this._rId >= 10 ? this._rId.toString() : "0" + this._rId.toString();
            this.tf_id.htmlText = HtmlUtil.font(str1,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),13);
            var _temp_1:* = this.tf_roleName;
            this.tf_bangName.text = "";
            _temp_1.text = "";
            this.btn_qiangduo.label = LangConfig.getWord("21133",2);
            this._info.id = 0;
            return;
         }
         this._info.rid = array[0];
         this._info.id = array[1];
         this._info.name = Model_heFu.repNameByHero(array[2]);
         this._info.job = array[4];
         this._info.bangName = array[6];
         if(this._info.id == GameUnitManager.hero.id)
         {
            this.btn_qiangduo.label = LangConfig.getWord("21134",2);
         }
         else
         {
            this.btn_qiangduo.label = LangConfig.getWord("21133",2);
         }
         var str:String = this._info.rid >= 10 ? this._info.rid.toString() : "0" + this._info.rid.toString();
         this.tf_id.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),13);
         if(this._info.id == GameUnitManager.hero.id)
         {
            this.tf_roleName.htmlText = this._info.name;
         }
         else
         {
            this.tf_roleName.htmlText = HtmlUtil.createLink("<font color=\'#" + Enum_job.JOBCOLOR[this._info.job - 1] + "\'>" + this._info.name + "</font>");
         }
         this.tf_bangName.text = this._info.bangName;
      }
      
      private function qiangDuoClickHandle(evt:MouseEvent) : void
      {
         var s:Array = null;
         var pip:View_lqqdPlayerInfoPanel = UIManager.lqqdPlayerInfoPanel;
         if(this.btn_qiangduo.label == LangConfig.getWord("21133",2))
         {
            if(Model_guajiInfo.getInstance().haslqRoom == true)
            {
               Child_lqqdRefreshTip.getInstance().show(2,this.qiangduo);
            }
            else
            {
               this.qiangduo();
            }
            s = Model_guajiInfo.getInstance().lqRoomInfoArr;
         }
         else if(this.btn_qiangduo.label == LangConfig.getWord("21134",2))
         {
            Child_lqqdRefreshTip.getInstance().show(3,this.sendLeaveRoomProtocol);
         }
      }
      
      private function sendLeaveRoomProtocol() : void
      {
         GuaJiCGMessage.CG_LEAVE_LQROOM(UIManager.lqqdPlayerInfoPanel.currentType,this._info.rid,GameUnitManager.hero.id);
      }
      
      private function previewClickHandle(evt:Event) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this._info.id);
      }
      
      private function qiangduo(evt:MouseEvent = null) : void
      {
         var secStr:String = null;
         var currentTime:int = getTimer();
         var subTime:int = currentTime - Model_guajiInfo.getInstance().qiangDuoLastTime;
         if(subTime < 60000 && this._info.id != 0)
         {
            secStr = int((60000 - subTime) / 1000).toString();
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21135",2,secStr));
         }
         else
         {
            GuaJiCGMessage.CG_SNATCH_LQROOM(UIManager.lqqdPlayerInfoPanel.currentType,this._rId,this._info.id);
         }
      }
   }
}

