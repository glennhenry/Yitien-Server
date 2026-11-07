package com.yiTian.view.modules.activity.kaifuItem.tuangou
{
   import com.ui.containers.Canvas;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.activity.kaifuItem.Child_KaifuViewBase;
   
   public class Child_ShouChongTuanGou extends Child_KaifuViewBase
   {
      
      private var txtThemeOne:MyTextField;
      
      private var txtThemeTwo:MyTextField;
      
      private var txtThemeThree:MyTextField;
      
      private var tf_title:MyTextField;
      
      private var tf_rwDescript:MyTextField;
      
      private var tf_actDescrpit:MyTextField;
      
      private var tf_ljDescript:MyTextField;
      
      private var continer:Canvas;
      
      private var bgs:ScaleBitmap;
      
      private var _len:int;
      
      private var itemVec:Vector.<child_activityItem> = new Vector.<child_activityItem>();
      
      private var _isInitt:Boolean = false;
      
      private var _vo:AcitivityVo;
      
      public function Child_ShouChongTuanGou()
      {
         super();
         this.initUI2();
      }
      
      public static function get instance() : Child_ShouChongTuanGou
      {
         return Singleton.getInstance(Child_ShouChongTuanGou);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":153,
            "y":230,
            "width":420,
            "height":255
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":154,
            "y":231,
            "width":418,
            "height":26
         },Global.Img_Cdm);
         this.txtThemeOne = ComponentUtil.getTextField("奖励条件",this,{
            "x":170,
            "y":234,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtThemeTwo = ComponentUtil.getTextField("奖励",this,{
            "x":350,
            "y":234,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtThemeThree = ComponentUtil.getTextField("操作",this,{
            "x":515,
            "y":234,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.createItem();
         this._isInitt = true;
         if(Boolean(this._vo))
         {
            this.updateItem(this._vo);
         }
      }
      
      private function createItem() : void
      {
         var item:child_activityItem = null;
         var i:int = 0;
         i = 0;
         while(i < 5)
         {
            item = new child_activityItem();
            item.x = 155;
            item.y = 250 + 45 * i;
            addChild(item);
            item.visible = true;
            this.itemVec.push(item);
            i++;
         }
      }
      
      public function set itemLength(len:int) : void
      {
         this._len = len;
      }
      
      public function updateItem(vo:AcitivityVo) : void
      {
         this._vo = vo;
         if(!this._isInitt)
         {
            return;
         }
         var _len:int = int(vo.allConditionDes.length);
         var i:int = 0;
         while(i < _len)
         {
            this.itemVec[i].update(vo.id,i + 1,vo.allConditionDes[i],vo.allConditionStatus[i],vo.allConditionReward[i],vo.allConditionDes1[i]);
            i++;
         }
      }
      
      public function flyIcon(i:int) : void
      {
         if(Boolean(this.itemVec[i]))
         {
            this.itemVec[i].flyIcon();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(this._isInitt)
            {
               super.visible = value;
               return;
            }
         }
         else
         {
            super.visible = value;
         }
      }
   }
}

