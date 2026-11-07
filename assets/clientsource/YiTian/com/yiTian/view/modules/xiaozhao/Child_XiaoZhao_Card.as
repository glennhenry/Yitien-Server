package com.yiTian.view.modules.xiaozhao
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_XiaoZhao;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.model.Model_XiaoZhao;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.XiaoZhaoCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.View_Cost_TipWin;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.petD.EffectPan;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class Child_XiaoZhao_Card extends EffectPan
   {
      
      private static const PROPID:int = 1;
      
      private var grid:View_Grid;
      
      private var _index:int;
      
      private var bgZM:Bitmap;
      
      private var bgFM:Sprite;
      
      private var pName:MyTextField;
      
      private var _vo:XiaoZhao_PropVO;
      
      private var bb:Bitmap;
      
      private var conBB:Sprite;
      
      public function Child_XiaoZhao_Card()
      {
         super();
         t_w = 111;
         t_h = 158;
         this.initUI();
      }
      
      private function initUI() : void
      {
         this.bgZM = ComponentUtil.getBitmap("Brand_ZhengMian",this,{
            "x":0,
            "y":0
         },Global.XZJZdm);
         this.bgFM = new Sprite();
         this.addChild(this.bgFM);
         ComponentUtil.getBitmap("Brand_FanMian",this.bgFM,{
            "x":0,
            "y":0
         },Global.XZJZdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this.bgFM,{
            "x":20,
            "y":23
         },Global.XZJZdm);
         ComponentUtil.getBitmap("Light_XZJZ",this.bgFM,{
            "x":9,
            "y":110
         },Global.XZJZdm);
         this.pName = ComponentUtil.getTextField("00000x10",this.bgFM,{
            "x":4,
            "y":113,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.pName.mouseEnabled = true;
         this.pName.realWidth = 109;
         this.pName.align = TextAlign.CENTER;
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         this.setBg(false);
      }
      
      private function setBg(b:Boolean) : void
      {
         this.bgZM.visible = !b;
         this.bgFM.visible = b;
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         var send:Function = null;
         send = function():void
         {
            if(GameUnitManager.hero.money >= Enum_XiaoZhao.nextCost())
            {
               Model_XiaoZhao.curIndex = index;
               XiaoZhaoCGMessage.CG_XIAOZHAO_GET_WARD(index);
            }
            else
            {
               UIManager.centerBroadcast.addMsg("您的元宝不足,请先充值");
            }
         };
         if(View_XiaoZhao.isTweening)
         {
            return;
         }
         if(CommandManager.get_bag_count(Enum_XiaoZhao.PROPID) >= 1)
         {
            View_Cost_TipWin.show("xz_props","花费12个道具进行翻牌？",send);
         }
         else
         {
            View_Cost_TipWin.show("xz_prop","花费" + Enum_XiaoZhao.nextCost() + "元宝进行翻牌？",send);
         }
      }
      
      private function setWard(isFly:Boolean) : void
      {
         var item:Vo_item;
         var str:String = null;
         this.setBg(true);
         if(this.hasEventListener(MouseEvent.CLICK))
         {
            this.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         if(Boolean(this.grid))
         {
            this.grid.empty();
            this.pName.htmlText = "";
         }
         else
         {
            this.grid = new View_Grid(true);
            this.grid.x = 24;
            this.grid.y = 27;
         }
         item = new Vo_item();
         item.id = this.vo.propId;
         item.Init_lib();
         this.grid.vo = item;
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_bmp_bg(null);
         this.grid.set_bmp_over(true,null);
         this.grid.set_tf_count(true,true,true);
         if(item.color == Enum_color.WHITE)
         {
            str = ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         else if(item.color == Enum_color.GREEN)
         {
            str = ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         else if(item.color == Enum_color.BLUE)
         {
            str = ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         else if(item.color == Enum_color.PURPLE)
         {
            str = ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         else if(item.color == Enum_color.ORANGE)
         {
            str = ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         str = HtmlUtil.font(item.str_name + "*" + this.vo.count,str,12);
         this.pName.htmlText = str;
         this.addChild(this.grid);
         if(isFly)
         {
            visible = false;
            visible = true;
            setTimeout(function():void
            {
               Tween.gridToBagBezierFuncDef(grid);
            },500);
         }
      }
      
      public function reset() : void
      {
         if(Boolean(this.grid))
         {
            this.grid.empty();
         }
         this.setBg(false);
         this._vo = null;
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function setData(state:int, pVo:XiaoZhao_PropVO = null, isFly:Boolean = false) : void
      {
         if(Boolean(pVo))
         {
            this.setBg(state == Enum_XiaoZhao.STATE_GET);
            this.vo = pVo;
            this.setWard(isFly);
         }
         else
         {
            this.reset();
         }
      }
      
      public function get vo() : XiaoZhao_PropVO
      {
         return this._vo;
      }
      
      public function set vo(value:XiaoZhao_PropVO) : void
      {
         this._vo = value;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
      }
      
      public function get bgBmp() : BitmapData
      {
         return this.bgZM.bitmapData;
      }
   }
}

