package com.yiTian.view.modules.role
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class RolePanelTip extends Sprite
   {
      
      private var back:DisplayObject;
      
      private var lineVec:Vector.<DisplayObject>;
      
      private var txtVec:Vector.<MyTextField>;
      
      private var txtFoot:MyTextField;
      
      public function RolePanelTip()
      {
         var txt:MyTextField = null;
         var line:DisplayObject = null;
         super();
         this.back = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,null,Global.Img_Cdm);
         this.txtVec = new Vector.<MyTextField>();
         this.lineVec = new Vector.<DisplayObject>();
         var textFormat:TextFormat = new TextFormat();
         textFormat.leading = 4;
         var i:uint = 0;
         while(i < 5)
         {
            txt = ComponentUtil.getTextField("",this);
            txt.defaultTextFormat = textFormat;
            this.txtVec.push(txt);
            txt.x = 15;
            i++;
         }
         i = 0;
         while(i < 3)
         {
            line = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{"x":15},Global.Img_Cdm);
            this.lineVec.push(line);
            i++;
         }
         this.txtFoot = ComponentUtil.getTextField("",this,{"color":11515029});
         this.txtFoot.wordWrap = true;
         this.txtFoot.x = 15;
         this.txtFoot.multiline = true;
      }
      
      public function updata(view:Object, strVec:Vector.<String>, _type:int = 0) : void
      {
         var len:int = 0;
         if(_type == 1)
         {
            this.txtFoot.htmlText = HtmlUtil.font("无法查询详情！","#fe0000");
            this.txtFoot.y = 7;
            this.txtFoot.x = 5;
            this.back.height = this.txtFoot.y + this.txtFoot.textHeight + 15;
            this.back.width = this.txtFoot.x + this.txtFoot.textWidth + 3;
            return;
         }
         len = int(strVec.length);
         if(view is View_role_equip || (view is Sprite || view.parent is Sprite) && view.tabIndex == 101)
         {
            this.back.width = 280;
            this.txtVec[0].y = 10;
            this.txtVec[0].htmlText = "<font size=\'16\' color=\'#F9FF00\'>" + LangConfig.getWord("10006",1) + "</font>";
            this.txtVec[1].y = 61;
            this.txtVec[2].y = 150;
            this.lineVec[0].y = 50;
            this.lineVec[1].y = 140;
            this.lineVec[2].y = 219;
            this.lineVec[0].width = this.lineVec[1].width = this.lineVec[2].width = 250;
            this.txtFoot.realWidth = 260;
            this.txtFoot.htmlText = "<font color=\'\'>" + LangConfig.getWord("10007",1) + "</font>";
            this.txtVec[3].visible = false;
            this.txtVec[4].visible = false;
            this.txtVec[1].visible = true;
            this.txtVec[1].htmlText = strVec[0];
            this.txtFoot.x = 15;
            if(len > 1)
            {
               this.lineVec[2].visible = true;
               this.txtVec[2].visible = true;
               this.txtVec[2].htmlText = strVec[1];
               this.txtFoot.y = this.txtVec[2].y + this.txtVec[2].textHeight + 25;
               this.back.height = this.txtFoot.y + this.txtFoot.textHeight + 15;
            }
            else
            {
               this.lineVec[2].visible = false;
               this.txtVec[2].visible = false;
               this.txtFoot.y = this.lineVec[1].y + 10;
               this.back.height = this.txtFoot.y + this.txtFoot.textHeight + 15;
            }
         }
         else if(view is View_role_meridian)
         {
            this.back.width = 215;
            this.txtVec[0].y = 15;
            this.txtVec[1].y = 49.3;
            this.txtVec[2].y = 163;
            this.txtVec[3].y = 197.3;
            this.lineVec[0].y = 38.3;
            this.lineVec[2].y = 306;
            this.lineVec[0].width = this.lineVec[1].width = this.lineVec[2].width = 185;
            this.txtFoot.realWidth = 184.2;
            this.txtFoot.htmlText = "<font color=\'\'>" + LangConfig.getWord("10008",1) + "</font>";
            this.txtVec[0].htmlText = strVec[0];
            this.txtVec[1].htmlText = strVec[1];
            if(len > 2)
            {
               this.lineVec[1].y = 186.3;
               this.lineVec[2].visible = true;
               this.txtVec[2].visible = true;
               this.txtVec[3].visible = true;
               this.txtVec[2].htmlText = strVec[2];
               this.txtVec[3].htmlText = strVec[3];
               this.txtFoot.y = this.txtVec[3].y + this.txtVec[3].textHeight + 25;
               this.back.height = this.txtFoot.y + this.txtFoot.textHeight + 15;
            }
            else
            {
               this.lineVec[1].y = 150;
               this.lineVec[2].visible = false;
               this.txtVec[2].visible = false;
               this.txtVec[3].visible = false;
               this.txtFoot.y = this.txtVec[1].y + this.txtVec[1].textHeight + 25;
               this.back.height = this.txtFoot.y + this.txtFoot.textHeight + 15;
            }
         }
      }
      
      override public function get height() : Number
      {
         return this.back.height;
      }
      
      override public function get width() : Number
      {
         return this.back.width;
      }
   }
}

