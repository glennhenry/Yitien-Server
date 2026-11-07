package com.yiTian.view.modules.bianxinggaiming
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.data.model.Model_initStr;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.net.message.cg.BianXingGaiMingCGMessage;
   import com.yiTian.scene.CreateScene;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.role.Enum_role_equip;
   import flash.display.DisplayObject;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class BianXingGaiMingPanel extends Panel
   {
      
      private var btnOK:Button;
      
      private var btnCancel:Button;
      
      private var txtInput:MyTextField;
      
      private const strDefault:String = "点击输入";
      
      private var _vo:Vo_valuable;
      
      private var pattern:RegExp = /([^一-龥0-9A-Za-z])+/;
      
      public function BianXingGaiMingPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var b:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":328,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":280,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":90,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":64,
            "y":95,
            "width":200,
            "height":24
         },Global.Img_Cdm);
         move = new Rectangle(0,0,b.width,35);
         ComponentUtil.getTextField(LangConfig.getWord("60035",6),this,{
            "x":96,
            "y":60,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.txtInput = ComponentUtil.getTextField(this.strDefault,this,{
            "x":64,
            "y":97,
            "color":16777215,
            "type":TextFieldType.INPUT,
            "realWidth":192
         });
         this.txtInput.addEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
         this.txtInput.align = TextFormatAlign.CENTER;
         this.btnOK = ComponentUtil.getButton(LangConfig.getWord("60036",6),"Button_Four",this,{
            "x":64,
            "y":132,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnOK.addEventListener(MouseEvent.CLICK,this.btnOnClick);
         this.btnCancel = ComponentUtil.getButton(LangConfig.getWord("60037",6),"Button_Four",this,{
            "x":192,
            "y":132,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.btnOnClick);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":294,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm).addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      protected function onMouseDown(e:MouseEvent) : void
      {
         if(e.target != this.txtInput && this.txtInput.text == "")
         {
            this.txtInput.text = this.strDefault;
         }
      }
      
      protected function focusInHandler(e:FocusEvent) : void
      {
         if(e.target.text == this.strDefault)
         {
            e.target.text = "";
         }
      }
      
      public function gaiMing(vo:Vo_valuable) : void
      {
         this._vo = vo;
         this.visible = true;
      }
      
      private function btnOnClick(e:MouseEvent) : void
      {
         switch(e.target.label)
         {
            case LangConfig.getWord("60036",6):
               if(GameUnitManager.hero.status == Status.SIT)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60038",6));
                  return;
               }
               if(Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] != 3 || Global.sceneMap == 12304)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60039",6));
                  return;
               }
               if(this.txtInput.text.length == 0 || this.txtInput.text == this.strDefault)
               {
                  UIManager.centerBroadcast.addMsg(Model_initStr.NAME_NOT_NULL);
               }
               else if(this.txtInput.text.length < 2 || this.txtInput.text.length > 6)
               {
                  UIManager.centerBroadcast.addMsg(Model_initStr.NAME_LENGHT);
               }
               else if(this.pattern.test(this.txtInput.text))
               {
                  UIManager.centerBroadcast.addMsg(Model_initStr.NAME_COM);
               }
               else if(this.txtInput.text == GameUnitManager.hero.name)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60040",6));
               }
               else
               {
                  StrFilter.load(this.txtInput.text,function(text:String):void
                  {
                     if(StrFilter.hasUnRegisterString(text))
                     {
                        UIManager.centerBroadcast.addMsg(LangConfig.getWord("60041",6));
                     }
                     else if(CreateScene.strHd(text))
                     {
                        UIManager.centerBroadcast.addMsg(LangConfig.getWord("60042",6));
                     }
                     else
                     {
                        if(GameUnitManager.hero.level < _vo.lv_use)
                        {
                           UIManager.centerBroadcast.addMsg(LangConfig.getWord("60043",6));
                           return;
                        }
                        BianXingGaiMingCGMessage.CG_GAI_MING(text);
                        UIManager.bianXingGaiMing.visible = false;
                     }
                  });
               }
               break;
            case LangConfig.getWord("60037",6):
               visible = false;
         }
      }
      
      public function bianXingHandler(vo:Vo_valuable) : void
      {
         View_Alert.show(LangConfig.getWord("60044",6),View_Alert.OK_CANCAL,function():void
         {
            if(Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] != 3 || Global.sceneMap == 12304)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60039",6));
               return;
            }
            if(GameUnitManager.hero.level < vo.lv_use)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60043",6));
               return;
            }
            if(Boolean(GameUnitManager.hero.marriageRing))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60045",6));
               return;
            }
            if(Boolean(CommandManager.get_role_vec_equip()[Enum_role_equip.FASHION]))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60046",6));
               return;
            }
            if(GameUnitManager.hero.status == Status.SIT)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60038",6));
               return;
            }
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

