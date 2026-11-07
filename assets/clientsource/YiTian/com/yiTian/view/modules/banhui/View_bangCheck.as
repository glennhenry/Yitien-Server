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
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_bangCheck extends Panel
   {
      
      private static var isLoad:Boolean = false;
      
      private var Button_Join:Button;
      
      private var BHName_text:MyTextField;
      
      private var BHLever_text:MyTextField;
      
      private var BHCaiFu_text:MyTextField;
      
      private var BZName_text:MyTextField;
      
      private var Member_text:MyTextField;
      
      private var BHXuanYan_text:MyTextField;
      
      private var _partyId:Number;
      
      public function View_bangCheck()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":409,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":360,
            "height":230
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":270,
            "y":50,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":270,
            "y":81,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":95,
            "y":80,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":95,
            "y":50,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":95,
            "y":110,
            "width":105,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":34,
            "y":161,
            "width":340,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60011",6),this,{
            "x":34,
            "y":51,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60012",6),this,{
            "x":34,
            "y":81,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60013",6),this,{
            "x":34,
            "y":111,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60014",6),this,{
            "x":210,
            "y":81,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60015",6),this,{
            "x":34,
            "y":141,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60016",6),this,{
            "x":210,
            "y":51,
            "color":11904647,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,350,38);
         this.Button_Join = ComponentUtil.getButton(LangConfig.getWord("939",0),"Button_Four",this,{
            "x":167,
            "y":243,
            "textColor":14013822
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":371,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.BHXuanYan_text = ComponentUtil.getTextField(LangConfig.getWord("60017",6),this,{
            "x":52,
            "y":174,
            "color":16764206,
            "size":12,
            "leading":0,
            "realWidth":300,
            "realHeight":65,
            "wordWrap":true,
            "multiline":true
         });
         this.BHName_text = ComponentUtil.getTextField(LangConfig.getWord("60018",6),this,{
            "x":104,
            "y":51,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.BHCaiFu_text = ComponentUtil.getTextField("000000000",this,{
            "x":105,
            "y":111,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.BHLever_text = ComponentUtil.getTextField("000",this,{
            "x":106,
            "y":81,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.BZName_text = ComponentUtil.getTextField(LangConfig.getWord("60019",6),this,{
            "x":280,
            "y":51,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.Member_text = ComponentUtil.getTextField("000/000",this,{
            "x":280,
            "y":81,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.BHName_text.align = TextAlign.CENTER;
         this.BHCaiFu_text.align = TextAlign.CENTER;
         this.BZName_text.align = TextAlign.CENTER;
         this.Member_text.align = TextAlign.CENTER;
         this.Button_Join.addEventListener(MouseEvent.CLICK,this.applyBangHandle);
      }
      
      public function applyBangHandle(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("50031",5));
            return;
         }
         BangCGMessage.CG_BANG_APPLY(this._partyId);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.Bang_Imgsdm)
            {
               SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
               {
                  Global.Bang_Imgsdm = info.applicationDomain;
                  showB();
               });
            }
            else if(!isLoad)
            {
               this.showB();
            }
         }
      }
      
      private function showB() : void
      {
         ComponentUtil.getBitmap("Title_BangCheck",this,{
            "x":124,
            "y":5
         },Global.Bang_Imgsdm);
         isLoad = true;
      }
      
      public function update(partyId:Number, BangName_str:String, BangZhu_str:String, Lever_str:int, members:int, partyMemNumLimit:int, fortune:int, declaration:String) : void
      {
         this._partyId = partyId;
         this.BHName_text.text = BangName_str;
         this.BZName_text.text = BangZhu_str;
         this.BHLever_text.text = String(Lever_str);
         this.Member_text.text = String(members) + "/" + String(partyMemNumLimit);
         this.BHCaiFu_text.text = String(fortune);
         this.BHXuanYan_text.text = declaration;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

