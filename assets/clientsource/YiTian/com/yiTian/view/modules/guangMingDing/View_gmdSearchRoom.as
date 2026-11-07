package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   
   public class View_gmdSearchRoom extends Panel123
   {
      
      private var _tfInput:MyTextField;
      
      private var _btnCommit:Button;
      
      private var _btnCancel:Button;
      
      private var _staticStr:String;
      
      public var id:int;
      
      public function View_gmdSearchRoom()
      {
         super();
         regResource("lang/ch/GuangMingDing_Img.swf","GuangMingDing_Imgdm");
         bindParent = GameScene.sysLayer;
      }
      
      public static function get instance() : View_gmdSearchRoom
      {
         return Singleton.getInstance(View_gmdSearchRoom);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_CZFJ",this,{
            "x":74,
            "y":4
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":54,
            "y":95,
            "width":200,
            "height":24
         },Global.Img_Cdm);
         move = new Rectangle(0,0,width,35);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":width - 37,
            "y":6,
            "callBack":this.changeVis
         },Global.Img_Cdm);
         ComponentUtil.getTextField("请输入你需要查找的房间号码",this,{
            "x":72,
            "y":55,
            "color":14540049
         });
         this._tfInput = ComponentUtil.getTextField("",this,{
            "x":57,
            "y":98,
            "maxChars":10,
            "color":13424242,
            "restrict":"0-9",
            "type":TextFieldType.INPUT,
            "realWidth":192
         },"center",TextFieldType.INPUT);
         this._tfInput.autoSize = TextFieldAutoSize.CENTER;
         this._btnCommit = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":55,
            "y":152,
            "textColor":16184781,
            "callBack":this.commitClickHd
         },Global.Img_Cdm);
         this._btnCancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":175,
            "y":152,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         this._staticStr = "点我输入";
         this._tfInput.addEventListener(FocusEvent.FOCUS_IN,this.focusInHd);
         this._tfInput.addEventListener(FocusEvent.FOCUS_OUT,this.focusOutHd);
         Global.control.registerCallBack(Msg_guangMingDing.HALLPANEL_HIDE,this.hide);
      }
      
      public function show(param:* = null) : void
      {
         this._tfInput.text = this._staticStr;
         visible = true;
         this.id = param;
      }
      
      public function hide(param:* = null) : void
      {
         visible = false;
      }
      
      public function changeVis(param:* = null) : void
      {
         Global.delegate.dosomething(this,visible ? this.hide : this.show);
      }
      
      private function focusInHd(e:FocusEvent) : void
      {
         if(this._tfInput.text == this._staticStr)
         {
            this._tfInput.text = "";
         }
      }
      
      private function focusOutHd(e:FocusEvent) : void
      {
         if(this._tfInput.text == "")
         {
            this._tfInput.text = this._staticStr;
         }
      }
      
      private function commitClickHd(e:MouseEvent) : void
      {
         if(this._tfInput.text != this._staticStr && this._tfInput.text != "")
         {
            if(Number(this._tfInput.text).toString() != "NaN")
            {
               GuangMingDingCGMessage.CG_GMD_SEARCH_ROOM(Number(this._tfInput.text));
            }
         }
      }
   }
}

