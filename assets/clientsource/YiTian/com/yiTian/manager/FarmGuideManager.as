package com.yiTian.manager
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_farm_guide;
   import com.yiTian.utils.Tween;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class FarmGuideManager
   {
      
      private static var _instance:FarmGuideManager;
      
      private var guideObj:Sprite;
      
      private var vo:Vo_farm_guide;
      
      public function FarmGuideManager()
      {
         super();
      }
      
      public static function get instance() : FarmGuideManager
      {
         if(!_instance)
         {
            _instance = new FarmGuideManager();
         }
         return _instance;
      }
      
      public function setGuide(type:uint, totalCount:uint = 0) : void
      {
         if(type == Vo_farm_guide.type_guide_none)
         {
            if(Boolean(this.guideObj) && Boolean(this.guideObj.parent))
            {
               this.guideObj.parent.removeChild(this.guideObj);
            }
            this.vo = null;
         }
         this.vo = new Vo_farm_guide();
         this.vo.type = type;
         this.vo.isComplete = false;
         this.vo.currentStep = 0;
         this.vo.totalStep = totalCount;
         this.vo.step = new Vector.<uint>();
         this.vo.step.push(0);
         var i:uint = 0;
         while(i < this.vo.totalStep)
         {
            this.vo.step.push(1);
            i++;
         }
      }
      
      public function nextStep(step:uint) : void
      {
         if(!this.vo || this.vo.type == Vo_farm_guide.type_guide_none)
         {
            return;
         }
         if(step > this.vo.totalStep)
         {
            this.vo = null;
            this.setGuide(0);
            return;
         }
         if(this.vo.step[step - 1] != 0 || this.vo.step[step] == 0)
         {
            return;
         }
         this.vo.currentStep = step;
         this.vo.step[step] = 0;
         if(!this.guideObj)
         {
            this.guideObj = ComponentUtil.getDisplayObject("farm_arrow",null,null,Global.ShanZhuang_Imgsdm) as Sprite;
            this.guideObj.mouseEnabled = false;
         }
         if(this.vo.type == Vo_farm_guide.type_guide_plant)
         {
            this.doPlantGuide();
         }
         else if(this.vo.type == Vo_farm_guide.type_guide_farmer)
         {
            this.doFarmerGuide();
         }
      }
      
      private function doPlantGuide() : void
      {
         if(this.vo.currentStep == 1)
         {
            this.doGuide(UIManager.farm.treasureChest,135,UIManager.farm.treasureChest.width,0);
         }
         else if(this.vo.currentStep == 2)
         {
            this.doGuide(UIManager.treasureChest.itemArr[0],-130,208 + 65,20 + 45);
         }
         else if(this.vo.currentStep == 3)
         {
            this.doGuide(UIManager.buySeed.Button_Buy,135,UIManager.buySeed.Button_Buy.width + 5,0 - 30);
         }
         else if(this.vo.currentStep == 4)
         {
            this.doGuide(UIManager.treasureChest.guidePoint,135,30,-20);
         }
         else if(this.vo.currentStep == 5)
         {
            this.doGuide(UIManager.farm._seedList[0],135,UIManager.farm._seedList[0].width + 5,-15);
         }
         else if(this.vo.currentStep == 6)
         {
            this.doGuide(UIManager.farm._lands[0],135,UIManager.farm._lands[0].width,0);
         }
      }
      
      public function doFarmerGuide() : void
      {
         if(this.vo.currentStep == 1)
         {
            this.doGuide(UIManager.farm._farmerList[0],-135,UIManager.farm._farmerList[0].width - 35,85);
         }
      }
      
      private function doGuide(obj:DisplayObject, rotation:Number, dx:Number, dy:Number, addBorder:Boolean = true) : void
      {
         var startPoint:Point = null;
         if(Boolean(this.guideObj.parent))
         {
            startPoint = obj.parent.globalToLocal(this.guideObj.parent.localToGlobal(new Point(this.guideObj.x,this.guideObj.y)));
            obj.parent.addChild(this.guideObj);
            this.guideObj.x = startPoint.x;
            this.guideObj.y = startPoint.y;
            Tween.to(this.guideObj,400,{
               "x":[this.guideObj.x,obj.x + dx],
               "y":[this.guideObj.y,obj.y + dy],
               "rotation":[this.guideObj.rotation,rotation]
            },this.onCom,null,Tween.SIN);
         }
         else
         {
            obj.parent.addChild(this.guideObj);
            this.guideObj.x = obj.x + dx;
            this.guideObj.y = obj.y + dy;
            this.guideObj.rotation = rotation;
         }
      }
      
      public function show() : void
      {
         if(Boolean(this.guideObj) && Boolean(this.guideObj.parent))
         {
            this.guideObj.visible = true;
         }
      }
      
      public function hide() : void
      {
         if(Boolean(this.guideObj) && Boolean(this.guideObj.parent))
         {
            this.guideObj.visible = false;
         }
      }
      
      private function onCom() : void
      {
      }
   }
}

