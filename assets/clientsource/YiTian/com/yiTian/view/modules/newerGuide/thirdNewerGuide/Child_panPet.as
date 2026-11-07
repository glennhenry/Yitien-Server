package com.yiTian.view.modules.newerGuide.thirdNewerGuide
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.treeDownCL.lUtils.DescripPan;
   import com.yiTian.view.modules.treeDownCL.lUtils.MoveRoundPan;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class Child_panPet extends Panel123
   {
      
      private var moveDescriItem:DescripPan;
      
      private var lastTime:int;
      
      public function Child_panPet()
      {
         super();
         regResource("lang/ch/XinShou_3.swf","XinShou_3dm");
      }
      
      public static function get instance() : Child_panPet
      {
         return Singleton.getInstance(Child_panPet);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":472,
            "height":350
         },Global.Img_Cdm);
         move = new Rectangle(0,0,472,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":424,
            "height":300
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":404,
            "height":254
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_Pet",this,{
            "x":36,
            "y":52
         },Global.XinShou_3dm);
         ComponentUtil.getButton("","Button_Back",this,{
            "x":41,
            "y":146,
            "textColor":16184781,
            "tabIndex":1,
            "callBack":this.changedHd
         },Global.XinShou_3dm);
         ComponentUtil.getButton("","Button_Next",this,{
            "x":162,
            "y":146,
            "textColor":16184781,
            "tabIndex":2,
            "callBack":this.changedHd
         },Global.XinShou_3dm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":436,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         initDynamicView();
         ComponentUtil.getBitmap("Title_Pet",this,{
            "x":156,
            "y":5
         },Global.XinShou_3dm);
         ComponentUtil.getButton("购买","Button_TwoBule91",this,{
            "x":184,
            "y":307,
            "textColor":16184781,
            "callBack":Model_thirdNewer.butHd,
            "tabIndex":1
         },Global.Img_Cdm);
         this.moveDescriItem = new DescripPan(108,150);
         addChild(this.moveDescriItem);
         this.moveDescriItem.setMask({
            "x":57,
            "y":91,
            "width":108,
            "height":150
         });
      }
      
      private function changedHd(e:MouseEvent) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime < 600)
         {
            return;
         }
         this.lastTime = now;
         var obj:Object = this.getTypePanMove((e.target as Button).tabIndex);
         this.moveDescriItem.addItem(PetUniContainer.instance,obj.moveStyle,obj.data);
      }
      
      private function getTypePanMove(type:int) : Object
      {
         var obj:Object = new Object();
         if(type == 1)
         {
            obj.moveStyle = MoveRoundPan.LEFT_MOVE;
            obj.data = {
               "id":Model_thirdNewer.nextPetId,
               "way":2,
               "state":1
            };
         }
         else if(type == 2)
         {
            obj.moveStyle = MoveRoundPan.RIGHT_MOVE;
            obj.data = {
               "id":Model_thirdNewer.prePetId,
               "way":6,
               "state":1
            };
         }
         return obj;
      }
      
      public function show() : void
      {
         visible = !visible;
         if(!visible)
         {
            return;
         }
         this.moveDescriItem.addItem(PetUniContainer.instance,MoveRoundPan.LEFT_MOVE,{
            "id":Model_thirdNewer.nextPetId,
            "way":2,
            "state":1
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 400) / 2;
         y = (Global.stage.stageHeight - 250) / 2;
      }
   }
}

