package com.yiTian.view.modules.fubenSel.newAdd
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class ComposeItem extends Sprite
   {
      
      private static var _instance:ComposeItem;
      
      private static var isInit:Boolean = false;
      
      private static var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private static const arr_id:Array = [46251,46252,46253,46254,46255];
      
      private var savedData:Array;
      
      public function ComposeItem()
      {
         super();
         GameScene.popupLayer.addChild(this);
      }
      
      public static function get instance() : ComposeItem
      {
         if(!_instance)
         {
            _instance = new ComposeItem();
         }
         return _instance;
      }
      
      public function init() : void
      {
         var i:int;
         var g:View_Grid = null;
         var voI:Vo_item = null;
         if(isInit)
         {
            return;
         }
         this.visible = false;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":388,
            "height":207
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":340,
            "height":157
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_Get",this,{
            "x":34,
            "y":50
         },Global.Map_Imgsdm);
         i = 0;
         while(i < 5)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over(true,null);
            g.set_tf_count(true,true,true);
            voI = new Vo_item();
            voI.id = arr_id[i];
            voI.Init_lib();
            g.vo = voI;
            ComponentUtil.setPropertie(g,{
               "x":73 + i * 52,
               "y":115
            });
            gridVec.push(g);
            ComponentUtil.getBitmap("Icon_03",this,{
               "x":67 + i * 52,
               "y":110
            },Global.Map_Imgsdm);
            addChild(g);
            i++;
         }
         ComponentUtil.getButton("","Button_Close",this,{
            "x":354,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_FenJie",this,{
            "x":114,
            "y":5
         },Global.Map_Imgsdm);
         isInit = true;
         this.update(this.savedData);
      }
      
      public function update(arr:Array) : void
      {
         var gg:View_Grid = null;
         var i:int = 0;
         var g:View_Grid = null;
         var j:int = 0;
         var id:int = 0;
         var count:int = 0;
         if(!arr || !arr.length)
         {
            return;
         }
         if(!isInit)
         {
            this.savedData = arr;
            this.init();
            return;
         }
         for each(gg in gridVec)
         {
            gg.count = 0;
            gg.filters = Util.disabled;
         }
         i = 0;
         while(i < gridVec.length)
         {
            g = gridVec[i];
            j = 0;
            while(j < arr.length)
            {
               id = int(arr[j][1]);
               count = int(arr[j][2]);
               if(g.vo.id == id)
               {
                  g.count = count;
                  if(g.count > 0)
                  {
                     g.filters = [];
                  }
               }
               j++;
            }
            i++;
         }
         if(!visible)
         {
            this.visible = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var sx:int = 0;
         var sy:int = 0;
         super.visible = value;
         if(value)
         {
            sx = (Global.stage.stageWidth - 375) / 2 + 375 / 2;
            sy = (Global.stage.stageHeight - 200) / 2 + 200 / 2;
            Tween.to(this,200,{
               "scaleX":[0,1],
               "scaleY":[0,1],
               "x":[sx,sx - 375 / 2],
               "y":[sy,sy - 200 / 2]
            });
         }
      }
   }
}

