package com.yiTian.view.modules.jingJiChang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.LangConfig;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class View_item_paiMing extends Sprite
   {
      
      public static const EXTENDSLEN:int = 30;
      
      private var Button_CaoZuo:Button;
      
      private var Name_text:MyTextField;
      
      private var PaiMing_text:MyTextField;
      
      private var Lever_text:MyTextField;
      
      private var _price:int = 1;
      
      public var _name:String;
      
      public var getColor:Array = ["0xffff00","0x04ff00","0x33ccff","0xff00ff"];
      
      public var _roleId:Number = 0;
      
      public var _paiMing:int;
      
      public var _level:int;
      
      public var _job:int;
      
      public var _sex:int;
      
      public var _petId:int;
      
      public var _pet_icon:int;
      
      public var hr_pos:int;
      
      public var pet_pos:int;
      
      public function View_item_paiMing()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":27,
            "width":250 + EXTENDSLEN,
            "height":2
         },Global.Img_Cdm);
         this.Button_CaoZuo = ComponentUtil.getButton(LangConfig.getWord("312",0),"Button_Two",this,{
            "x":198 + EXTENDSLEN,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Name_text = ComponentUtil.getTextField(LangConfig.getWord("313",0),this,{
            "x":4,
            "y":5,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.PaiMing_text = ComponentUtil.getTextField("000",this,{
            "x":105 + EXTENDSLEN - 6,
            "y":5,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Lever_text = ComponentUtil.getTextField("000",this,{
            "x":148 + EXTENDSLEN - 3,
            "y":5,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":52,
            "align":TextFormatAlign.CENTER
         });
         this.Button_CaoZuo.addEventListener(MouseEvent.CLICK,this.checkHandle);
         this.Button_CaoZuo.addEventListener(MouseEvent.MOUSE_DOWN,this.downHandle);
      }
      
      private function downHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function checkHandle(e:MouseEvent) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this._roleId);
      }
      
      public function set playerName(str:String) : void
      {
         str = Model_heFu.repNameByHero(str);
         this.Name_text.textColor = this.getColor[Enum_job.getBaseJob(this._job) - 1];
         this._name = str;
         this.Name_text.text = str;
      }
      
      public function set pai_ming(_pai_ming:int) : void
      {
         this._paiMing = _pai_ming;
         this.PaiMing_text.textColor = 16711680;
         this.PaiMing_text.text = String(this._paiMing);
      }
      
      public function set level(_lvl:int) : void
      {
         this._level = _lvl;
         this.Lever_text.textColor = 16763955;
         this.Lever_text.text = String(this._level);
      }
   }
}

