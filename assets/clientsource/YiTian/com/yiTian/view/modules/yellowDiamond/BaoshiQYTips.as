package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BaoshiQYTips extends Panel
   {
      
      private static var _ins:BaoshiQYTips;
      
      private static var ss:String = "1月8日00:00至1月12日23:59分，参加宝石情缘合成5级以上" + "（包含5级）的宝石或灵石即可随机获得宝石或灵石一颗。\n" + "<font color=\'#04ff00\'>" + "例：合成1颗5级宝石随机赠送1颗4级宝石。" + "</font>";
      
      private var Button_Yes:Button;
      
      private var shap:Shape;
      
      private var spri:Sprite;
      
      public function BaoshiQYTips()
      {
         super();
         this.initB();
      }
      
      public static function get instance() : BaoshiQYTips
      {
         if(!_ins)
         {
            _ins = new BaoshiQYTips();
         }
         return _ins;
      }
      
      private function initB() : void
      {
         var str:String;
         var txt:MyTextField;
         var sss:String;
         var ssss:String;
         bindParent = GameScene.uiLayer;
         this.shap = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChild(this.shap);
         mouseEnabled = false;
         this.spri = new Sprite();
         addChild(this.spri);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.spri,{
            "x":0,
            "y":0,
            "width":348,
            "height":179
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.spri,{
            "x":29,
            "y":45,
            "width":290,
            "height":120
         },Global.Img_Cdm);
         str = "";
         if(Global.pf == Enum_SPStr.QZONE)
         {
            str = HtmlUtil.font("QQ空间","#f9ff00");
         }
         else if(Global.pf == Enum_SPStr.QQGAME)
         {
            str = HtmlUtil.font("QQ大厅","#f9ff00");
         }
         else if(Global.pf == Enum_SPStr.PENGYOU)
         {
            str = HtmlUtil.font("朋友网","#f9ff00");
         }
         else if(Global.pf == Enum_SPStr.QQ3366)
         {
            str = HtmlUtil.font("3366","#f9ff00");
         }
         else if(Enum_SPStr.isIwan(Global.pf))
         {
            str = HtmlUtil.font("爱玩","#f9ff00");
         }
         ComponentUtil.getTextField("宝石情缘",this.spri,{
            "x":85 + 50,
            "y":6,
            "color":16184781,
            "realWidth":245,
            "size":16,
            "bold":true
         });
         txt = ComponentUtil.getTextField("",this.spri,{
            "x":44,
            "y":55,
            "color":16184781,
            "realWidth":272,
            "realHeight":100,
            "multiline":true,
            "wordWrap":true,
            "leading":3
         });
         sss = ss.replace("{0}",str);
         ssss = sss.replace("1月8日00:00至1月12日23:59分",Global.BaoShiQYTimecrl);
         txt.htmlText = ssss;
         this.Button_Yes = ComponentUtil.getButton("合成宝石","Button_Four",this.spri,{
            "x":115 + 20,
            "y":115 + 14,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Yes.addEventListener(MouseEvent.CLICK,this.cliHd);
         ComponentUtil.getButton("","Button_Close",this.spri,{
            "x":317,
            "y":6,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         visible = false;
         UIManager.castPanel.visible = true;
         UIManager.castPanel.openView(Enum_panel_cast.GEM_COMPOSE);
      }
      
      override public function resetPosition() : void
      {
         this.spri.x = (Global.stage.stageWidth - 350) / 2;
         this.spri.y = (Global.stage.stageHeight - 130) / 2;
         this.shap.width = Global.stage.stageWidth;
         this.shap.height = Global.stage.stageHeight;
      }
   }
}

