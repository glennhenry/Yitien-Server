package com.yiTian.view
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.mainMenu.MicroButton;
   import com.yiTian.view.modules.roleHead.VIP_item;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class DrawObj
   {
      
      private static var sourStr:Array = ["Button_Round","Button_HuoDong","Button_Gift","Button_Point"];
      
      private static var dic_bmp:Dictionary = new Dictionary();
      
      private static var dic_spri:Dictionary = new Dictionary();
      
      private static var tf_dic:Dictionary = new Dictionary();
      
      public static const counts:int = 2;
      
      public function DrawObj()
      {
         super();
      }
      
      public static function drawObj(target:Object, point:Point, _sour:String) : void
      {
         var spri:Sprite = null;
         var tf:MyTextField = null;
         var bmp:Bitmap = null;
         var bmd:BitmapData = null;
         var dis:Bitmap = null;
         var b:Bitmap = null;
         if(!dic_bmp[target])
         {
            spri = new Sprite();
            tf = ComponentUtil.getTextField("",null,{"bold":true});
            if(target is Button)
            {
               bmp = new Bitmap();
               if((target as Button).label != "")
               {
                  tf.text = "";
               }
               bmd = ComponentUtil.getBitmapData(_sour + "_up",Global.Img_Cdm);
               bmp.bitmapData = bmd;
               dic_bmp[target] = bmp;
               tf_dic[target] = tf;
            }
            else if(target is MicroButton)
            {
               dis = ComponentUtil.getBitmap(_sour,null,null,Global.Img_Cdm);
               dic_bmp[target] = dis;
            }
            else if(target is VIP_item)
            {
               b = new Bitmap();
               b.bitmapData = ComponentUtil.getBitmapData(_sour);
               dic_bmp[target] = b;
            }
            dic_spri[target] = spri;
            tf_dic[target] = tf;
         }
         dic_spri[target].scaleX = 1;
         dic_spri[target].scaleY = 1;
         tf_dic[target].x = 6;
         tf_dic[target].y = 4;
         dic_spri[target].addChild(dic_bmp[target]);
         dic_spri[target].addChild(tf_dic[target]);
         GameScene.upUILayer.addChild(dic_spri[target]);
         dic_spri[target].x = point.x;
         dic_spri[target].y = point.y;
         Tween.to(dic_spri[target],400,{
            "scaleX":[1,counts],
            "scaleY":[1,counts],
            "alpha":[1,0],
            "x":[point.x,point.x - dic_spri[target].width / 2],
            "y":[point.y,point.y - dic_spri[target].height / 2]
         },function():void
         {
            GameScene.upUILayer.removeChild(dic_spri[target]);
            dic_spri[target].removeChild(dic_bmp[target]);
            dic_spri[target].removeChild(tf_dic[target]);
         });
      }
      
      private static function handle(_index:int) : String
      {
         if(_index == 0)
         {
            return sourStr[1];
         }
         if(_index == 1)
         {
            return sourStr[2];
         }
         if(_index == 2)
         {
            return sourStr[3];
         }
         return sourStr[0];
      }
   }
}

