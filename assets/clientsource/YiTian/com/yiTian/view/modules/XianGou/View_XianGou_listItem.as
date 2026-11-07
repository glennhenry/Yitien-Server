package com.yiTian.view.modules.XianGou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.XianGouCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class View_XianGou_listItem extends Sprite
   {
      
      private var _id:int;
      
      private var kuncun_spr:Sprite;
      
      private var _kucun:MyTextField;
      
      private var _yuanjia:MyTextField;
      
      private var shape:Shape;
      
      private var _heishijia:MyTextField;
      
      private var _xiangou:MyTextField;
      
      private var grid0:Sprite;
      
      private var grid1:Sprite;
      
      private var grid2:Sprite;
      
      private var grid3:Sprite;
      
      private var grid4:Sprite;
      
      private var v_grid0:View_Grid;
      
      private var v_grid1:View_Grid;
      
      private var v_grid2:View_Grid;
      
      private var v_grid3:View_Grid;
      
      private var v_grid4:View_Grid;
      
      private var flyArr:Array;
      
      private var buyButton:Button;
      
      public function View_XianGou_listItem()
      {
         super();
         this.Init();
      }
      
      private function Init() : void
      {
         ComponentUtil.getBitmap("BG_Light2",this,{
            "x":234,
            "y":11
         },Global.XianGoudm);
         this.grid0 = new Sprite();
         this.grid1 = new Sprite();
         this.grid2 = new Sprite();
         this.grid3 = new Sprite();
         this.grid4 = new Sprite();
         ComponentUtil.getBitmap("Grid_Open",this.grid0,{
            "x":7,
            "y":11
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this.grid1,{
            "x":47,
            "y":11
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this.grid2,{
            "x":87,
            "y":11
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this.grid3,{
            "x":127,
            "y":11
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this.grid4,{
            "x":167,
            "y":11
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < 5)
         {
            this["v_grid" + i] = new View_Grid();
            View_Grid(this["v_grid" + i]).set_tf_count();
            View_Grid(this["v_grid" + i]).set_bmp_over();
            View_Grid(this["v_grid" + i]).isAutoLoad = true;
            this["grid" + i].addChild(this["v_grid" + i]);
            this["v_grid" + i].x = 7 + 40 * i + 3;
            this["v_grid" + i].y = 11 + 3;
            this.addChild(this["grid" + i]);
            i++;
         }
         this.kuncun_spr = new Sprite();
         this.addChild(this.kuncun_spr);
         this.kuncun_spr.visible = false;
         ComponentUtil.getBitmap("BG_KuCun",this.kuncun_spr,{
            "x":-1,
            "y":-7
         },Global.XianGoudm);
         ComponentUtil.getTextField("剩余库存:",this.kuncun_spr,{
            "x":5,
            "y":-6,
            "color":15856113,
            "size":12,
            "leading":0
         });
         this._yuanjia = ComponentUtil.getTextField("原   价: 999元宝",this,{
            "x":250,
            "y":12,
            "color":15856113,
            "size":12,
            "leading":0
         });
         this.shape = new Shape();
         this.addChild(this.shape);
         this._heishijia = ComponentUtil.getTextField("黑市价: 50元宝",this,{
            "x":250,
            "y":34,
            "color":327424,
            "size":12,
            "leading":0
         });
         this._xiangou = ComponentUtil.getTextField("限购:9个",this,{
            "x":365,
            "y":12,
            "color":14211192,
            "size":12,
            "leading":0
         });
         this._kucun = ComponentUtil.getTextField("100个",this.kuncun_spr,{
            "x":59,
            "y":-5,
            "color":14211192,
            "size":12,
            "leading":0
         });
         this.buyButton = ComponentUtil.getButton("立即抢购","Button_QiangGou",this,{
            "x":356,
            "y":31,
            "textColor":16771436
         },Global.XianGoudm);
         this.buyButton.callBack = this.buy;
      }
      
      private function buy(e:*) : void
      {
         XianGouCGMessage.CG_BUY(this._id);
      }
      
      public function set id(num:int) : void
      {
         this._id = num;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set item(arr:Array) : void
      {
         var item:Vo_item = null;
         trace("****set item");
         this.flyArr = [];
         var i:int = 0;
         while(i < 5)
         {
            if(arr[i][0] == 0)
            {
               this["grid" + i].visible = false;
            }
            else
            {
               this["grid" + i].visible = true;
               item = new Vo_item();
               item.id = arr[i][0];
               item.Init_lib();
               View_Grid(this["v_grid" + i]).vo = item;
               View_Grid(this["v_grid" + i]).count = arr[i][1];
               this.flyArr.push(this["v_grid" + i]);
            }
            i++;
         }
      }
      
      public function set yuanjia(num:int) : void
      {
         this._yuanjia.text = "原   价: " + num + "元宝";
      }
      
      public function set heishijia(num:int) : void
      {
         this._heishijia.text = "黑市价: " + num + "元宝";
      }
      
      public function set xiangou(num:int) : void
      {
         if(num == 0)
         {
            this._xiangou.text = "限购:" + num + "个";
         }
         else if(num > 0)
         {
            this._xiangou.text = "限购:" + num + "个";
         }
         else
         {
            this._xiangou.text = "";
         }
      }
      
      public function set kucun(num:int) : void
      {
         if(num == 0)
         {
            this.kuncun_spr.visible = true;
            this._kucun.text = num + "个";
         }
         else if(num > 0)
         {
            this.kuncun_spr.visible = true;
            this._kucun.text = num + "个";
         }
         else
         {
            this.kuncun_spr.visible = false;
         }
      }
      
      public function FlyToBag() : void
      {
         var i:* = undefined;
         trace("****flyArr",this.flyArr.length);
         for(i in this.flyArr)
         {
            ComboTweenStep.toBag(this.flyArr[i]);
         }
      }
   }
}

