package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.banhui.BangBuilding.Enum_BangMap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_bangCreate extends Panel
   {
      
      private static var isAdd:Boolean = false;
      
      private var Button_Great:Button;
      
      private var Name_text:MyTextField;
      
      private var BHXuanYan_text:MyTextField;
      
      public var isBang:Boolean = false;
      
      public var sameName:Boolean = true;
      
      public function View_bangCreate()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":368,
            "height":270
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":320,
            "height":220
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":34,
            "y":70,
            "width":300,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":34,
            "y":120,
            "width":300,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60008",6),this,{
            "x":44,
            "y":205,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60009",6),this,{
            "x":160,
            "y":48,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60010",6),this,{
            "x":160,
            "y":98,
            "color":11904647,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,230,38);
         this.Button_Great = ComponentUtil.getButton(LangConfig.getWord("50025",5),"Button_Four",this,{
            "x":150,
            "y":227,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":330,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Name_text = ComponentUtil.getTextField("",this,{
            "x":78,
            "y":73,
            "color":14662240,
            "realWidth":200,
            "realHeight":20
         });
         this.BHXuanYan_text = ComponentUtil.getTextField(LangConfig.getWord("50026",5),this,{
            "x":44,
            "y":128,
            "color":14662240,
            "leading":6,
            "realWidth":192,
            "width":192,
            "multiline":true,
            "wordWrap":true,
            "realHeight":70
         });
         this.Name_text.restrict = "^_|,";
         this.Name_text.type = TextFieldType.INPUT;
         this.Name_text.align = TextAlign.CENTER;
         this.Name_text.maxChars = 6;
         this.BHXuanYan_text.type = TextFieldType.INPUT;
         this.BHXuanYan_text.maxChars = 50;
         this.Button_Great.callBack = this.createBangHandle;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.focus = this.Name_text;
            if(!Global.Bang_Imgsdm)
            {
               SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
               {
                  Global.Bang_Imgsdm = info.applicationDomain;
                  showBmp();
               });
            }
            else
            {
               this.showBmp();
            }
         }
         else
         {
            this.reset();
         }
      }
      
      private function showBmp() : void
      {
         isAdd = true;
         ComponentUtil.getBitmap("Title_BangCreat",this,{
            "x":104,
            "y":5
         },Global.Bang_Imgsdm);
      }
      
      private function reset() : void
      {
         this.BHXuanYan_text.text = LangConfig.getWord("29168",2);
         this.Name_text.text = "";
      }
      
      public function createBangHandle(e:MouseEvent) : void
      {
         var partyName:String = null;
         var declaration:String = null;
         var pattern:RegExp = /^(新手之家)/g;
         if(this.Name_text.text == "")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29169",2));
            return;
         }
         if(this.Name_text.text.match(pattern).length > 0)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff33\'>不能使用该名称,<font color=\'#ff33ff\'>\"新手之家\"</font>为系统保留名称</font>");
            return;
         }
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < Enum_BangMap.BANGCREATECOST)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29170",2));
            return;
         }
         partyName = this.Name_text.text;
         declaration = this.BHXuanYan_text.text;
         StrFilter.load(partyName,function(text:String):void
         {
            var tipName:String = null;
            if(StrFilter.hasUnRegisterString(text))
            {
               tipName = StrFilter.takeUnRegisterString(text);
               UIManager.centerBroadcast.addMsg(tipName);
               return;
            }
            StrFilter.load(declaration,function(text:String):void
            {
               var tipName:String = null;
               if(StrFilter.hasUnRegisterString(text))
               {
                  tipName = StrFilter.takeUnRegisterString(text);
                  UIManager.centerBroadcast.addMsg(tipName);
                  return;
               }
               var reg2:RegExp = /[<.]/gi;
               var temp:String = partyName.match(reg2).toString();
               if(temp.length > 0)
               {
                  UIManager.centerBroadcast.addMsg("不能包含<font color=\'#ff3333\'>.&lt;&gt;</font>等符号");
                  return;
               }
               BangCGMessage.CG_BANG_BUILD(partyName,declaration);
            });
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

