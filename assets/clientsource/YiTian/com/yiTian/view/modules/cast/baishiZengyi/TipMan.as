package com.yiTian.view.modules.cast.baishiZengyi
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class TipMan extends Sprite
   {
      
      private static var _instance:TipMan;
      
      private var bg:ScaleBitmap;
      
      private var tf:MyTextField;
      
      private var _oldW:Number = -1;
      
      private var _oldH:Number = -1;
      
      private var line:ScaleBitmap;
      
      private var dic:Dictionary = new Dictionary();
      
      private var lvlObj:Object;
      
      public function TipMan()
      {
         super();
         this.bg = ComponentUtil.getScaleBitmap("tipsBG",[14,12,20,6],this,{
            "x":0,
            "y":0,
            "width":87,
            "height":95
         },Global.Img_Cdm);
         this.tf = ComponentUtil.getTextField("",this,{"color":11527396});
         this.line = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":25,
            "width":356,
            "height":2
         },Global.Img_Cdm);
         GameScene.upUILayer.addChild(this);
         this.visible = false;
         this.line.visible = false;
      }
      
      public static function get instance() : TipMan
      {
         if(!_instance)
         {
            _instance = new TipMan();
         }
         return _instance;
      }
      
      public function bind(obj:DisplayObject, data:Object, lineEnabled:Boolean) : void
      {
         if(!this.dic[obj])
         {
            this.dic[obj] = obj;
         }
         this.lvlObj = data;
         if(this.lvlObj is String)
         {
            this.tf.htmlText = this.lvlObj.toString();
         }
         this.line.visible = lineEnabled;
         obj.addEventListener(MouseEvent.ROLL_OVER,this.rollOver);
         obj.addEventListener(MouseEvent.MOUSE_MOVE,this.moveHd);
         obj.addEventListener(MouseEvent.ROLL_OUT,this.rollOut);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var temNum:int = 0;
         var _num:int = 0;
         var str:String = null;
         var _str:String = null;
         super.visible = value;
         if(value)
         {
            if(this.lvlObj is int)
            {
               temNum = int(this.lvlObj);
               if(this.lvlObj > 0)
               {
                  _num = temNum >= View_baoshiZY.MAXLEVEL ? temNum : int(temNum + 1);
                  str = HtmlUtil.font("宝石增益：","#ffffff") + " Lv." + temNum + "\n\n" + HtmlUtil.font("当前等级：" + " " + "宝石效果","#f9ff00") + HtmlUtil.font(Data_lib.baoshi[temNum][1] + "%\n","#04ff00") + HtmlUtil.font("下一等级：" + " " + "宝石效果","#f9ff00") + HtmlUtil.font(Data_lib.baoshi[_num][1] + "%","#04ff00");
                  this.tf.htmlText = str;
               }
               else
               {
                  _str = HtmlUtil.font("宝石增益：","#ffffff") + " Lv." + 0 + "\n\n" + HtmlUtil.font("当前等级：" + " " + "宝石效果","#f9ff00") + HtmlUtil.font(0 + "%\n","#04ff00") + HtmlUtil.font("下一等级：" + " " + "宝石效果","#f9ff00") + HtmlUtil.font(Data_lib.baoshi[0 + 2][1] + "%","#04ff00");
                  this.tf.htmlText = _str;
               }
            }
         }
      }
      
      private function rollOver(e:MouseEvent) : void
      {
         var wid:int = 0;
         var hei:int = 0;
         if(!visible)
         {
            this.visible = true;
         }
         x = Global.stage.mouseX + 10;
         y = Global.stage.mouseY + 5;
         wid = this.tf.width;
         hei = this.tf.height;
         this.bg.x = -1;
         this.bg.y = -1;
         this.tf.x = 3;
         this.tf.y = 2;
         this.bg.width = wid + 6;
         this.bg.height = hei + 6;
         this.line.width = this.bg.width - 2;
      }
      
      private function moveHd(e:MouseEvent) : void
      {
         if(visible)
         {
            x = Global.stage.mouseX + 10;
            y = Global.stage.mouseY + 5;
         }
      }
      
      private function rollOut(e:MouseEvent) : void
      {
         this.visible = false;
      }
   }
}

