package com.yiTian.view.modules.kuafujingjichang.extralDill
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class LianZhanUnit extends Sprite
   {
      
      private static var _instance:LianZhanUnit;
      
      private static const WID:int = 35;
      
      private static const HEI:int = 35;
      
      private static var bmUrlArr:Array = ["Num_0","Num_1","Num_2","Num_3","Num_4","Num_5","Num_6","Num_7","Num_8","Num_9","Num_10","Num_Bai","Num_Qian"];
      
      private static var bmPool:Array = [];
      
      private var bmCon:Sprite;
      
      private var temBmArr:Array = [];
      
      private var _property:Object;
      
      private var posArr:Array = [];
      
      public function LianZhanUnit()
      {
         super();
         ComponentUtil.getBitmap("Back_Killing",this,null,Global.DRKF_Imgsdm);
         this.bmCon = new Sprite();
         addChild(this.bmCon);
         ComponentUtil.setPropertie(this.bmCon,{
            "x":133,
            "y":64
         });
      }
      
      public static function get instance() : LianZhanUnit
      {
         if(!_instance)
         {
            _instance = new LianZhanUnit();
         }
         return _instance;
      }
      
      public function addLianZhan(value:int) : void
      {
         var midStr:String = null;
         this.removeTem();
         var str:String = "";
         if(value % 10 == 0 && value < 100)
         {
            str = value.toString().charAt(0) + "_10";
         }
         else if(value > 10 && value < 20)
         {
            str = "10_" + value.toString().charAt(1);
         }
         else if(value > 10 && value < 100 && value % 10 != 0)
         {
            str = value.toString().charAt(0) + "_10_" + value.toString().charAt(1);
         }
         else if(value > 100 && value < 110)
         {
            str = value.toString().charAt(0) + "_11_0_" + value.toString().charAt(2);
         }
         else if(value > 100 && value % 10 == 0 && value % 100 != 0)
         {
            str = value.toString().charAt(0) + "_11_" + value.toString().charAt(1) + "_10";
         }
         else if(value > 110 && value % 10 != 0)
         {
            midStr = value.toString().charAt(1);
            if(midStr == "0")
            {
               str = value.toString().charAt(0) + "_11_0_" + value.toString().charAt(2);
            }
            else
            {
               str = value.toString().charAt(0) + "_11_" + value.toString().charAt(1) + "_10_" + value.toString().charAt(2);
            }
         }
         else if(value % 100 == 0)
         {
            str = value.toString().charAt(0) + "_11";
         }
         else
         {
            str = value.toString();
         }
         this.generaBm(str);
      }
      
      public function set property(value:Object) : void
      {
         this._property = value;
         ComponentUtil.setPropertie(this,value);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Tween.to(this,500,{"y":[this._property.y - 200,this._property.y]},null,null,Tween.SIN);
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,Model_DRKF.beginHd);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_START,Model_DRKF.beginHd);
            this.removeTem();
         }
      }
      
      private function getBm() : Bitmap
      {
         if(Boolean(bmPool.length))
         {
            return bmPool.pop();
         }
         return new Bitmap();
      }
      
      private function removeTem() : void
      {
         var b:Bitmap = null;
         while(Boolean(this.temBmArr.length))
         {
            b = this.temBmArr.shift();
            if(Boolean(b.parent))
            {
               b.parent.removeChild(b);
            }
            bmPool.push(b);
            b.bitmapData = null;
         }
      }
      
      private function generaBm(s:String) : void
      {
         var i:int = 0;
         var n:int = 0;
         var url:String = null;
         var b:Bitmap = null;
         var arr:Array = s.split("_");
         this.posArr.length = 0;
         i = 0;
         while(i < arr.length)
         {
            n = int(arr[i]);
            url = bmUrlArr[n];
            b = this.getBm();
            b.bitmapData = ComponentUtil.getBitmapData(url,Global.DRKF_Imgsdm);
            ComponentUtil.setPropertie(b,{
               "x":WID * i,
               "y":-63
            });
            this.temBmArr.push(b);
            this.posArr.push({"x":WID * i});
            i++;
         }
         this.moveBm(0);
      }
      
      private function moveBm(count:int) : void
      {
         var b:Bitmap;
         var pro:Object;
         if(count >= this.temBmArr.length)
         {
            return;
         }
         b = this.temBmArr[count];
         pro = this.posArr[count];
         this.bmCon.addChild(b);
         Tween.to(b,300,{
            "x":[b.x,pro.x],
            "y":[b.y,-14]
         },function():void
         {
            moveBm(++count);
            shake();
         });
      }
      
      private function shake() : void
      {
         Tween.to(this,10,{"y":[this.y,this.y - 3]},this.shakeBack);
      }
      
      private function shakeBack() : void
      {
         Tween.to(this,10,{"y":[this.y,this.y + 3]});
      }
   }
}

