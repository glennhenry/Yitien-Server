package com.yiTian.view.modules.banhui
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.modules.banhui.BangBuilding.BangBuilding_Bar;
   import com.yiTian.view.modules.banhui.BangBuilding.BangBuilding_Base;
   import com.yiTian.view.modules.banhui.BangBuilding.BangBuilding_MainTown;
   import com.yiTian.view.modules.banhui.BangBuilding.BangBuilding_MoneyTree;
   import com.yiTian.view.modules.banhui.BangBuilding.BangBuilding_Shop;
   import com.yiTian.view.modules.banhui.BangBuilding.BangBuilding_SpaceArea;
   import com.yiTian.view.modules.banhui.BangBuilding.Building_FishPound;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BangMap extends Sprite
   {
      
      private var mainTown:BangBuilding_MainTown;
      
      private var spaceArea:BangBuilding_SpaceArea;
      
      private var shakeMoneyTree:BangBuilding_MoneyTree;
      
      private var bar:BangBuilding_Bar;
      
      private var shop:BangBuilding_Shop;
      
      private var fishPound:Building_FishPound;
      
      private var bangBg:Bitmap;
      
      private var buildingVec:Vector.<BangBuilding_Base>;
      
      private var isFirstShow:Boolean = false;
      
      public function BangMap()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":33,
            "y":71,
            "width":662,
            "height":372
         },Global.Img_Cdm);
         this.bangBg = new Bitmap();
         addChild(this.bangBg);
      }
      
      private function showBackGround() : void
      {
         this.bangBg = ComponentUtil.getBitmap("Bang_BackGround",this,{
            "x":34,
            "y":74
         },Global.Bang_Imgsdm);
         this.mainTown = new BangBuilding_MainTown(this,{
            "x":280,
            "y":205
         });
         this.fishPound = new Building_FishPound(this,{
            "x":393,
            "y":318
         });
         this.bar = new BangBuilding_Bar(this,{
            "x":427,
            "y":115
         });
         this.shop = new BangBuilding_Shop(this,{
            "x":34,
            "y":200
         });
         this.shakeMoneyTree = new BangBuilding_MoneyTree(this,{
            "x":150,
            "y":310
         });
         this.buildingVec = new Vector.<BangBuilding_Base>();
         this.buildingVec.push(this.mainTown,this.fishPound,this.shop,this.bar,this.shakeMoneyTree);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value == true)
         {
            if(!this.isFirstShow)
            {
               this.isFirstShow = true;
               if(Boolean(Global.Bang_Imgsdm))
               {
                  this.showBackGround();
               }
               else
               {
                  SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
                  {
                     Global.Bang_Imgsdm = info.applicationDomain;
                     showBackGround();
                  });
               }
            }
         }
         super.visible = value;
      }
      
      public function updateBuildingLevelInfo(type:int, level:int) : void
      {
         if(!this.buildingVec)
         {
            return;
         }
         if(Boolean(this.buildingVec[type - 1]))
         {
            this.buildingVec[type - 1].level = level;
         }
      }
      
      public function set shakeMoneyTreeCount(value:int) : void
      {
         if(Boolean(this.shakeMoneyTree))
         {
            this.shakeMoneyTree.barCount = value;
         }
      }
      
      private function storeHandle(e:MouseEvent) : void
      {
         if(!UIManager.bang_store.visible)
         {
            UIManager.bang_store.visible = true;
         }
         UIManager.bang_store.parent.setChildIndex(UIManager.bang_store,UIManager.bang_store.parent.numChildren - 1);
      }
   }
}

