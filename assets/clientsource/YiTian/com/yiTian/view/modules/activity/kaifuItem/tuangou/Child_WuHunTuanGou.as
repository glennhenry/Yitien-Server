package com.yiTian.view.modules.activity.kaifuItem.tuangou
{
   import com.ui.containers.Canvas;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.activity.kaifuItem.Child_KaifuViewBase;
   
   public class Child_WuHunTuanGou extends Child_KaifuViewBase
   {
      
      private var txtThemeOne:MyTextField;
      
      private var txtThemeTwo:MyTextField;
      
      private var txtThemeThree:MyTextField;
      
      private var continer:Canvas;
      
      private var bgs:ScaleBitmap;
      
      private var _len:int;
      
      private var itemVec:Vector.<wuhunItem> = new Vector.<wuhunItem>();
      
      private var _initt:Boolean = false;
      
      private var _vo:AcitivityVo;
      
      private var isFirst:Boolean = true;
      
      public function Child_WuHunTuanGou()
      {
         super();
         this.initUI2();
      }
      
      public static function get instance() : Child_WuHunTuanGou
      {
         return Singleton.getInstance(Child_WuHunTuanGou);
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
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.txtThemeTwo = ComponentUtil.getTextField("奖励",this,{
            "x":350,
            "y":234,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this._initt = true;
         if(Boolean(this._vo))
         {
            this.createItem(this._vo.id);
            this.updateItem(this._vo);
         }
      }
      
      public function createItem(id:int) : void
      {
         var item:wuhunItem = null;
         var i:int = 0;
         i = 0;
         while(i < 3)
         {
            item = new wuhunItem(id,i);
            item.x = 155;
            item.y = 255 + 77 * i;
            addChild(item);
            this.itemVec.push(item);
            i++;
         }
      }
      
      public function updateItem(vo:AcitivityVo) : void
      {
         var type:int = 0;
         var num:int = 0;
         var des:String = null;
         this._vo = vo;
         if(!this._initt)
         {
            return;
         }
         if(!this.itemVec.length)
         {
            this.createItem(this._vo.id);
         }
         this._len = vo.allConditionDes.length;
         var arr1:Array = [];
         var arr2:Array = [2,3,4];
         var i:int = 0;
         while(i < this._len)
         {
            des = "";
            arr1 = Data_lib.wuhuntuangou[i * 4 + 1][0].split("_");
            type = int(arr1[0]);
            num = int(arr1[1]);
            if(vo.id == Enum_KF.ID_WUHUNTUANGOU)
            {
               if(type == 3)
               {
                  des = "半年武魂人数";
               }
               else if(type == 2)
               {
                  des = "月武魂人数";
               }
               else if(type == 1)
               {
                  des = "周武魂人数";
               }
               des += "<font color=\'#00ff00\'>" + num + "</font>人\n达标人数：";
            }
            else if(vo.id == Enum_KF.ID_ZUOQITUANGOU)
            {
               arr1 = Data_lib.zuoqituangou[i * arr2[i] + 1][0].split("_");
               type = int(arr1[0]);
               num = int(arr1[1]);
               if(type == 1)
               {
                  des = "进阶到雄狮";
               }
               else if(type == 2)
               {
                  des = "进阶到独角兽";
               }
               else if(type == 3)
               {
                  des = "进阶到麒麟";
               }
               des += "<font color=\'#00ff00\'>" + num + "</font>人\n达标人数：";
            }
            this.itemVec[i].update(vo.id,i,vo.allConditionDes[i],vo.allConditionStatus[i],vo.allConditionReward[i],des);
            i++;
         }
         this._initt = true;
         if(this._initt)
         {
            this.visible = true;
         }
      }
      
      public function flyIcon() : void
      {
         if(Boolean(this.itemVec.length) && Boolean(this.itemVec[AcitivityVo.idIndex]))
         {
            this.itemVec[AcitivityVo.idIndex].flyIcon();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(this._initt)
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

