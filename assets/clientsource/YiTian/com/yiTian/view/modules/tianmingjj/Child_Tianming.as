package com.yiTian.view.modules.tianmingjj
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.TianMingHandler;
   import com.yiTian.net.message.cg.TianMingCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_Tianming extends Sprite
   {
      
      private static const FIRST_EFF_ID:int = 35142;
      
      private var lockSprite:Sprite;
      
      private var lockBM:Bitmap;
      
      private var curVo:Vo_TianMing;
      
      private var eff:Effect;
      
      private var contentTF:MyTextField;
      
      public var grid:View_Grid;
      
      private var baseView:Sprite;
      
      public function Child_Tianming(type:int, bg:String)
      {
         super();
         this.init(type,bg);
      }
      
      public function set lock(value:Boolean) : void
      {
         if(value)
         {
            this.grid.set_bmp_bg(View_Grid.GRID_TIANMING_LOCK);
         }
         else
         {
            this.grid.set_bmp_bg(View_Grid.GRID_TIANMING);
         }
      }
      
      public function updata(vo:Vo_TianMing, gridId:int) : void
      {
         this.disEff();
         this.grid.vo = vo;
         this.grid.gridId = gridId;
         this.curVo = vo;
         if(Boolean(vo) && Boolean(vo.str_name != "lock") && vo.str_name != null)
         {
            this.creatEff(vo);
         }
      }
      
      private function onLockHandle(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         TianMingCGMessage.CG_TIANMING_LOCK(this.curVo.id_server,this.grid.type - 27);
      }
      
      private function creatEff(vo:Vo_TianMing) : void
      {
         var id:int = (vo.id - Enum_TianMing.FIRSTID) % 5;
         if(id == 0)
         {
            return;
         }
         if(vo.color == 6)
         {
            this.eff = EffectManager.addEffect(Enum_TianMing.DJEFFECTID,this.baseView,800,20,20,true);
            return;
         }
         var str:String = FIRST_EFF_ID + id - 1 + "";
         this.eff = EffectManager.addEffect(str,this.baseView,800,20,20,true);
      }
      
      private function disEff() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
      }
      
      private function init(type:int, bg:String) : void
      {
         this.creatGrid(type,bg);
         this.initTF();
      }
      
      private function initTF() : void
      {
         this.contentTF = ComponentUtil.getTextField("",this,{
            "x":-10,
            "y":27,
            "size":11,
            "color":16777062
         });
         this.contentTF.align = "center";
         this.contentTF.multiline = true;
      }
      
      private function creatGrid(type:int, bg:String = null) : void
      {
         this.baseView = new Sprite();
         addChild(this.baseView);
         this.baseView.mouseEnabled = false;
         this.mouseEnabled = false;
         this.grid = new View_Grid();
         this.grid.type = type;
         this.grid.isAutoLoad = true;
         if(bg != null)
         {
            this.grid.set_bmp_bg(bg);
         }
         this.grid.set_bmp_over(true,View_Grid.GRID_TIANMING_OVER);
         this.grid.set_tf_count();
         this.baseView.addChild(this.grid);
         this.grid.addEventListener(MouseEvent.MOUSE_UP,TianMingHandler.grid_up);
         this.grid.addEventListener(MouseEvent.MOUSE_DOWN,this.gridDownFun);
      }
      
      private function gridDownFun(event:MouseEvent) : void
      {
         UIManager.startDrag(event);
      }
   }
}

