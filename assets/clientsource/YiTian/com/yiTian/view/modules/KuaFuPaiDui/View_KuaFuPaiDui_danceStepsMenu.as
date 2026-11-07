package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_KuaFuPaiDui;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class View_KuaFuPaiDui_danceStepsMenu extends Panel
   {
      
      private static var _instance:View_KuaFuPaiDui_danceStepsMenu;
      
      private var backGround:ScaleBitmap;
      
      private var backGround2:ScaleBitmap;
      
      private var bigBackGround:Bitmap;
      
      private var countDownPoint:Array;
      
      private var pressPoint:Bitmap;
      
      private var rightZone:Bitmap;
      
      private var arrowArr:Array;
      
      private var arrowBmdt:Array;
      
      private var perfectBm:Bitmap;
      
      private var leftTimeTxt:MyTextField;
      
      public function View_KuaFuPaiDui_danceStepsMenu()
      {
         super();
         init();
      }
      
      public static function get instance() : View_KuaFuPaiDui_danceStepsMenu
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_danceStepsMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var bm:Bitmap = null;
         var xx:int = 0;
         var arrow:Bitmap = null;
         bAutoRemove = false;
         this.bigBackGround = ComponentUtil.getBitmap("Back_WB",this,{
            "x":0,
            "y":0
         },Global.KFPDdm);
         this.bigBackGround.x = 147 - this.bigBackGround.width / 2;
         this.backGround = ComponentUtil.getScaleBitmap("Back_WBXS",[50,0,194,66],this,{
            "x":0,
            "y":45,
            "width":110,
            "height":66
         },Global.KFPDdm);
         this.backGround2 = ComponentUtil.getScaleBitmap("Back_WBDW",[10,0,251,60],this,{
            "x":11,
            "y":48,
            "width":110,
            "height":60
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Icon_KGJ",this,{
            "x":177,
            "y":115
         },Global.KFPDdm);
         var explainTxt:MyTextField = ComponentUtil.getTextField("",this,{
            "x":1,
            "y":118,
            "color":16772287,
            "size":12,
            "leading":0
         });
         explainTxt.htmlText = "（当指针移动到黄色色块时,敲击    <font color=\'#ffff00\'>空格键</font>    可完成）";
         this.countDownPoint = [];
         var i:int = 0;
         while(i < 5)
         {
            bm = ComponentUtil.getBitmap("Icon_DJSD",this,{
               "x":0,
               "y":22
            },Global.KFPDdm);
            bm.x = 1 + i * 15;
            this.countDownPoint.push(bm);
            i++;
         }
         ComponentUtil.getBitmap("Back_GDT",this,{
            "x":113,
            "y":19
         },Global.KFPDdm);
         this.rightZone = ComponentUtil.getBitmap("Icon_HSK",this,{
            "x":211,
            "y":24
         },Global.KFPDdm);
         this.pressPoint = ComponentUtil.getBitmap("Icon_GDD",this,{
            "x":126,
            "y":23
         },Global.KFPDdm);
         this.arrowBmdt = [];
         var rightBmdt:BitmapData = ComponentUtil.getBitmapData("Icon_ZQWB",Global.KFPDdm);
         var leftBmdt:BitmapData = new BitmapData(rightBmdt.width,rightBmdt.height,true,0);
         var yy:int = 0;
         while(yy < rightBmdt.height)
         {
            xx = 0;
            while(xx < rightBmdt.width)
            {
               leftBmdt.setPixel32(rightBmdt.width - xx - 1,yy,rightBmdt.getPixel32(xx,yy));
               xx++;
            }
            yy++;
         }
         this.arrowBmdt.push(leftBmdt);
         this.arrowBmdt.push(ComponentUtil.getBitmapData("Icon_CWWB",Global.KFPDdm));
         this.arrowBmdt.push(rightBmdt);
         this.arrowBmdt.push(ComponentUtil.getBitmapData("Icon_ZYBX",Global.KFPDdm));
         this.arrowBmdt.push(ComponentUtil.getBitmapData("Icon_ZYWB",Global.KFPDdm));
         this.arrowArr = [];
         var j:int = 0;
         while(j < 9)
         {
            arrow = ComponentUtil.getBitmap("Icon_CWWB",this,{
               "x":0,
               "y":63
            },Global.KFPDdm);
            arrow.visible = false;
            this.arrowArr.push(arrow);
            j++;
         }
         ComponentUtil.getTextField("剩余情侣舞活动倒计时：     秒",this,{
            "x":123,
            "y":0,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.leftTimeTxt = ComponentUtil.getTextField("0",this,{
            "x":260,
            "y":0,
            "color":327424,
            "size":12,
            "leading":0,
            "autoSize":"center"
         });
         this.perfectBm = ComponentUtil.getBitmap("TX_Perfect",this,{
            "x":78,
            "y":-200
         },Global.KFPDdm);
         this.perfectBm.alpha = 0;
         this.algin(0);
         this.mouseEnabled = false;
         this.mouseChildren = false;
         Global.control.registerCallBack(Enum_KuaFuPaiDui.INVITE_SUCCEED,this.show);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.BREAK_UP,this.hide);
      }
      
      private function show(e:*) : void
      {
         if(Model_KuaFuPaiDui.isDanceing)
         {
            this.visible = true;
         }
      }
      
      private function hide(e:*) : void
      {
         this.visible = false;
      }
      
      public function showPerfect() : void
      {
         Tween.to(this.perfectBm,3000,{"alpha":[1,0]});
      }
      
      public function setLeftTime(time:int) : void
      {
         this.leftTimeTxt.text = time.toString();
      }
      
      public function setCountDown(leftTime:int) : void
      {
         if(leftTime < 0 || leftTime > 5)
         {
            return;
         }
         var i:int = 0;
         while(i < 5)
         {
            if(i < leftTime)
            {
               this.countDownPoint[i].visible = true;
            }
            else
            {
               this.countDownPoint[i].visible = false;
            }
            i++;
         }
      }
      
      public function setSpaceBar(percent:Number) : void
      {
         percent %= 1;
         if(percent < 0)
         {
            percent += 1;
         }
         switch(percent)
         {
            case 0:
               this.pressPoint.x = 126;
               break;
            case 1:
               this.pressPoint.x = 126 + 142;
               break;
            default:
               this.pressPoint.x = 126 + int(142 * percent);
         }
      }
      
      public function creatArrow(arr:Array) : void
      {
         var i:* = undefined;
         var len:int = int(arr.length);
         var len2:int = Math.ceil(len / 2);
         for(i in this.arrowArr)
         {
            if(i < len)
            {
               this.arrowArr[i].visible = true;
               this.arrowArr[i].bitmapData = this.arrowBmdt[arr[i]];
               if(len % 2 == 0)
               {
                  this.arrowArr[i].x = 132 + (i + 1 - len2) * 40 - 20;
               }
               else
               {
                  this.arrowArr[i].x = 132 + (i + 1 - len2) * 40;
               }
            }
            else
            {
               this.arrowArr[i].visible = false;
            }
         }
         this.algin(len);
      }
      
      public function resetArrowRightWrong() : void
      {
         var i:* = undefined;
         for(i in this.arrowArr)
         {
            this.arrowArr[i].filters = [];
         }
      }
      
      public function setEnabled(id:int, isShow:Boolean) : void
      {
         if(isShow)
         {
            (this.arrowArr[id - 1] as Bitmap).filters = [];
         }
         else
         {
            (this.arrowArr[id - 1] as Bitmap).filters = Util.glowFF0000;
         }
      }
      
      public function setArrowRightWrong(id:int, isRight:int) : void
      {
         switch(isRight)
         {
            case 0:
               (this.arrowArr[id - 1] as Bitmap).filters = [];
               break;
            case 1:
               (this.arrowArr[id - 1] as Bitmap).filters = Util.glowFFFFFF;
               break;
            case 2:
               (this.arrowArr[id - 1] as Bitmap).filters = Util.glowFF0000;
         }
      }
      
      public function setRandomArrow(id:int, arrow:int) : void
      {
         this.arrowArr[id - 1].bitmapData = this.arrowBmdt[arrow];
      }
      
      public function checkSuccess() : Boolean
      {
         if(this.pressPoint.x > 200 && this.pressPoint.x < 252)
         {
            this.rightZone.filters = Util.glowFFFFFF;
            return true;
         }
         this.rightZone.filters = [];
         return false;
      }
      
      private function algin(num:int) : void
      {
         this.backGround.width = 110 + num * 30 + (num - 1) * 10;
         this.backGround2.width = 110 + num * 30 + (num - 1) * 10;
         this.backGround.x = -this.backGround.width / 2 + 147;
         this.backGround2.x = -this.backGround2.width / 2 + 147;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 295) / 2;
         y = Global.stage.stageHeight - 225;
      }
   }
}

