package com.yiTian.view.modules.activityGuide
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.Singleton;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Child_jiangliItem extends Sprite
   {
      
      private var txtThemeOne:MyTextField;
      
      private var txtThemeTwo:MyTextField;
      
      private var txtThemeThree:MyTextField;
      
      private var itemVec:Vector.<Child_ActivityGuide> = new Vector.<Child_ActivityGuide>();
      
      private var continer:Canvas;
      
      private var bgs:ScaleBitmap;
      
      private var _len:int;
      
      private var itemVec1:Vector.<Child_ActivityGuide> = new Vector.<Child_ActivityGuide>();
      
      public function Child_jiangliItem()
      {
         super();
         this.bgs = ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":5,
            "y":5,
            "width":440,
            "height":30
         },Global.Img_Cdm);
         this.txtThemeOne = ComponentUtil.getTextField("奖励条件",this,{
            "x":60,
            "y":9,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtThemeTwo = ComponentUtil.getTextField("奖励道具",this,{
            "x":230,
            "y":9,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtThemeThree = ComponentUtil.getTextField("领取",this,{
            "x":370,
            "y":9,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtThemeThree.visible = false;
         this.createItem();
      }
      
      public static function get instance() : Child_jiangliItem
      {
         return Singleton.getInstance(Child_jiangliItem);
      }
      
      private function createItem() : void
      {
         var item:Child_ActivityGuide = null;
         var i:int = 0;
         var a:* = undefined;
         i = 0;
         while(i < Enum_ActivityGuide.MAX_ITEM_NUM)
         {
            item = new Child_ActivityGuide();
            item.x = 5;
            item.y = 38 + 56 * i;
            addChild(item);
            a = Data_lib.xiaofeihuikui;
            item.getAwardTimes = int(Data_lib.xiaofeihuikui[i + 1][3]);
            item.visible = false;
            this.itemVec.push(item);
            i++;
         }
      }
      
      public function updateItem(vo:ActivityGuideVo) : void
      {
         var i:int = 0;
         var len:int = int(vo.allConditionReward.length);
         this._len = len;
         this.setVisible(len);
         if(vo.id == Enum_ActivityGuide.XIAOFEIHUIKUI)
         {
            this.txtThemeThree.visible = true;
            this.txtThemeTwo.text = "奖励";
            this.txtThemeTwo.x = 240;
            this.txtThemeOne.x = 60;
         }
         else if(vo.id == Enum_ActivityGuide.DENGLUYOULI)
         {
            this.bgs.visible = this.txtThemeTwo.visible = this.txtThemeOne.visible = true;
            this.bgs.width = 425;
            this.txtThemeThree.visible = true;
            this.txtThemeThree.text = "操作";
            this.txtThemeOne.x = 35;
            this.txtThemeTwo.x = 210;
         }
         else
         {
            this.txtThemeThree.visible = false;
            this.txtThemeTwo.x = 230;
            this.txtThemeTwo.text = "奖励道具";
            this.txtThemeOne.x = 60;
         }
         if(len > Enum_ActivityGuide.MAX_ITEM_NUM)
         {
            this.disposeNewItem();
            this.createNewItem(vo);
            return;
         }
         i = 0;
         while(i < Enum_ActivityGuide.MAX_ITEM_NUM)
         {
            if(i < len)
            {
               this.itemVec[i].update(vo.id,i,vo.allConditionDes[i],vo.allConditionStatus[i],vo.allConditionReward[i],vo.allConditionStatus2[i]);
               this.itemVec[i].visible = true;
            }
            else
            {
               this.itemVec[i].visible = false;
            }
            i++;
         }
      }
      
      private function disposeNewItem() : void
      {
         var i:int = 0;
         var item:Child_ActivityGuide = null;
         if(Boolean(this.continer))
         {
            if(Boolean(this.itemVec1.length))
            {
               i = 0;
               while(i < this.itemVec1.length)
               {
                  item = this.itemVec1[i];
                  if(Boolean(item.parent))
                  {
                     item.parent.removeChild(item);
                  }
                  item = null;
                  i++;
               }
               this.itemVec1 = null;
               this.itemVec1 = new Vector.<Child_ActivityGuide>();
            }
            this.continer.removeAllChildren();
            if(Boolean(this.continer.parent))
            {
               this.continer.parent.removeChild(this.continer);
            }
            this.continer = null;
         }
      }
      
      private function createNewItem(vo:ActivityGuideVo) : void
      {
         var item:Child_ActivityGuide = null;
         var i:int = 0;
         var shape:Shape = null;
         var len:int = int(vo.allConditionReward.length);
         if(!this.continer)
         {
            this.continer = new Canvas(451,208);
            if(vo.id == Enum_ActivityGuide.DENGLUYOULI)
            {
               this.addChildAt(this.continer,0);
               shape = ComponentUtil.getShape(425,10,662045);
               this.addChildAt(shape,1);
            }
            else
            {
               this.addChild(this.continer);
            }
            this.continer.scrollAutoType = ScrollAutoType.REMAIN;
         }
         var tempLen:int = int(this.itemVec1.length);
         if(tempLen < len)
         {
            i = tempLen;
            while(i < len)
            {
               item = new Child_ActivityGuide();
               item.x = 5;
               if(vo.id == Enum_ActivityGuide.DENGLUYOULI)
               {
                  item.y = 56 * i + 40;
               }
               else
               {
                  item.y = 56 * i + 10;
               }
               this.continer.addChild(item);
               item.visible = false;
               this.itemVec1.push(item);
               i++;
            }
         }
         i = 0;
         while(i < len)
         {
            if(i < len)
            {
               this.itemVec1[i].update(vo.id,i,vo.allConditionDes[i],vo.allConditionStatus[i],vo.allConditionReward[i]);
               this.itemVec1[i].visible = true;
            }
            else
            {
               this.itemVec1[i].visible = false;
            }
            i++;
         }
         this.continer.reset();
         this.continer.align();
      }
      
      private function setVisible(len:int) : void
      {
         var show:Boolean = len <= Enum_ActivityGuide.MAX_ITEM_NUM;
         this.bgs.visible = this.txtThemeTwo.visible = this.txtThemeOne.visible = show;
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            this.itemVec[i].visible = show;
            i++;
         }
         if(Boolean(this.continer))
         {
            this.continer.visible = !show;
         }
      }
      
      public function flyIcon(i:int) : void
      {
         if(this._len <= Enum_ActivityGuide.MAX_ITEM_NUM)
         {
            if(Boolean(this.itemVec[i]))
            {
               this.itemVec[i].flyIcon();
            }
         }
         else if(Boolean(this.itemVec1[i]))
         {
            this.itemVec1[i].flyIcon();
         }
      }
   }
}

