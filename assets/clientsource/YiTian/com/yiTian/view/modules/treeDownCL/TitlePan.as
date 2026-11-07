package com.yiTian.view.modules.treeDownCL
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class TitlePan extends Panel123
   {
      
      private static var last_time:int;
      
      private static var isInit:Boolean = false;
      
      private var titleBmF:Bitmap;
      
      private var titleBmS:Bitmap;
      
      private var titleTf:MyTextField;
      
      private var answerTfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var countTf:MyTextField;
      
      private var leftCon:Sprite;
      
      private var rightCon:Sprite;
      
      private var titleId:int;
      
      public function TitlePan()
      {
         super();
         addEventListener(MouseEvent.MOUSE_DOWN,this.movefun);
      }
      
      public static function get instance() : TitlePan
      {
         return Singleton.getInstance(TitlePan);
      }
      
      override protected function initUI2() : void
      {
         if(isInit)
         {
            return;
         }
         ComponentUtil.getBitmap("Back_Zhou",this,{
            "x":0,
            "y":0
         },Global.DaShu_Imgsdm);
         ComponentUtil.getBitmap("Text_Di",this,{
            "x":155,
            "y":27
         },Global.DaShu_Imgsdm);
         this.titleBmF = ComponentUtil.getBitmap("Text_02",this,{
            "x":174,
            "y":27
         },Global.DaShu_Imgsdm);
         this.titleBmS = ComponentUtil.getBitmap("Text_10",this,{
            "x":193,
            "y":27
         },Global.DaShu_Imgsdm);
         ComponentUtil.getBitmap("Text_Ti",this,{
            "x":212,
            "y":27
         },Global.DaShu_Imgsdm);
         this.titleTf = ComponentUtil.getTextField("位观（去掉描边）",this,{
            "x":37,
            "y":58,
            "color":524288,
            "size":12,
            "leading":4,
            "filters":Util.disabled,
            "realWidth":302,
            "multiline":true,
            "wordWrap":true
         });
         this.leftCon = new Sprite();
         addChild(this.leftCon);
         this.rightCon = new Sprite();
         addChild(this.rightCon);
         ComponentUtil.setPropertie(this.leftCon,{
            "x":71,
            "y":126
         });
         ComponentUtil.setPropertie(this.rightCon,{
            "x":222,
            "y":126
         });
         this.leftCon.mouseEnabled = this.leftCon.buttonMode = true;
         this.rightCon.mouseEnabled = this.rightCon.buttonMode = true;
         this.leftCon.tabIndex = 111;
         this.rightCon.tabIndex = 112;
         this.leftCon.addEventListener(MouseEvent.CLICK,this.choose);
         this.rightCon.addEventListener(MouseEvent.CLICK,this.choose);
         ComponentUtil.getBitmap("Icon_TLeft",this.leftCon,{
            "x":0,
            "y":0
         },Global.DaShu_Imgsdm);
         ComponentUtil.getBitmap("Icon_TRight",this.rightCon,{
            "x":0,
            "y":0
         },Global.DaShu_Imgsdm);
         ComponentUtil.getTextField("梅树",this.leftCon,{
            "x":45,
            "y":1,
            "color":16711551,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("桃树",this.rightCon,{
            "x":45,
            "y":1,
            "color":16711551,
            "size":12,
            "leading":0
         });
         this.answerTfVec.push(ComponentUtil.getTextField("叉叉叉答案",this,{
            "x":116,
            "y":148,
            "color":16758528,
            "size":12,
            "leading":0
         }),ComponentUtil.getTextField("叉叉叉答案",this,{
            "x":267,
            "y":148,
            "color":16758528,
            "size":12,
            "leading":0
         }));
         this.countTf = ComponentUtil.getTextField("15",this,{
            "x":328,
            "y":28
         });
         isInit = true;
         this.update(this.titleId);
      }
      
      private function choose(e:MouseEvent) : void
      {
         switch(e.target.tabIndex)
         {
            case 111:
               GameUnitManager.hero.go(Model_treeCL.pointL.x,Model_treeCL.pointL.y);
               break;
            case 112:
               GameUnitManager.hero.go(Model_treeCL.pointR.x,Model_treeCL.pointR.y);
         }
      }
      
      private function movefun(e:MouseEvent) : void
      {
         if(e.target.tabIndex == 111 || e.target.tabIndex == 112)
         {
            return;
         }
         GameScene.instance.uiOnGo(e);
      }
      
      public function update(id:int) : void
      {
         this.titleId = id;
         if(!isInit)
         {
            if(!Global.DaShu_Imgsdm)
            {
               SingleLoader.add("lang/ch/DaShu_Imgs.swf",function(info:Object):void
               {
                  Global.DaShu_Imgsdm = info.applicationDomain;
                  initUI2();
               });
            }
            else
            {
               this.initUI2();
            }
            return;
         }
         CountTfManager.remove(this.countTf);
         this.countTf.text = Model_treeCL.answerBegin.toString();
         CountTfManager.add(this.countTf,Model_treeCL.answerBegin,false,function(_count:int):void
         {
            if(_count <= 0)
            {
               CountTfManager.remove(countTf);
               visible = false;
            }
         });
         if(!visible)
         {
            this.visible = true;
         }
         this.showTitleInform();
      }
      
      private function showTitleInform() : void
      {
         var num1:String = null;
         var num2:String = null;
         var aswerS:String = null;
         var tf:MyTextField = null;
         this.titleBmF.bitmapData = null;
         this.titleBmS.bitmapData = null;
         var len:int = this.titleId.toString().length;
         if(len == 1 || this.titleId == 10)
         {
            if(this.titleId == 10)
            {
               this.titleBmF.bitmapData = ComponentUtil.getBitmapData("Text_10",Global.DaShu_Imgsdm);
            }
            else
            {
               this.titleBmF.bitmapData = ComponentUtil.getBitmapData("Text_0" + this.titleId,Global.DaShu_Imgsdm);
            }
            this.titleBmF.x = 184;
         }
         else
         {
            this.titleBmF.x = 174;
            num1 = this.titleId.toString().charAt(0);
            num2 = this.titleId.toString().charAt(1);
            if(int(num1) == 1)
            {
               this.titleBmF.bitmapData = ComponentUtil.getBitmapData("Text_10",Global.DaShu_Imgsdm);
               this.titleBmS.bitmapData = ComponentUtil.getBitmapData("Text_0" + num2,Global.DaShu_Imgsdm);
            }
            else if(int(num1) == 2)
            {
               this.titleBmF.bitmapData = ComponentUtil.getBitmapData("Text_0" + num1,Global.DaShu_Imgsdm);
               this.titleBmS.bitmapData = ComponentUtil.getBitmapData("Text_10",Global.DaShu_Imgsdm);
            }
         }
         var key:int = Model_treeCL.answerKey;
         var str:String = Data_lib.DSCLTitle[key][1];
         this.titleTf.text = Model_treeCL.currentTitle + "." + str;
         var i:int = 0;
         while(i < this.answerTfVec.length)
         {
            aswerS = Model_treeCL.answerArr[i];
            tf = this.answerTfVec[i];
            tf.text = aswerS;
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var now:int = 0;
         if(value)
         {
            if(alpha == 0)
            {
               alpha = 1;
            }
            super.visible = value;
            Tween.to(this,500,{"y":[-150,120]});
         }
         else
         {
            now = getTimer();
            if(now - last_time >= 1000)
            {
               Tween.to(this,500,{"y":[120,-200]},this.hide);
               last_time = now;
            }
         }
      }
      
      public function hide() : void
      {
         super.visible = false;
         CountTfManager.remove(this.countTf);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 300) / 2 - 47;
      }
   }
}

