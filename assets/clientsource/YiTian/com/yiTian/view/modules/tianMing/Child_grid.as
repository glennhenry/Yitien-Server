package com.yiTian.view.modules.tianMing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.model.Model_Tianming;
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.TianMingHandler;
   import com.yiTian.net.message.cg.TianMingCGMessage;
   import com.yiTian.net.message.cg.TianmingJJCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.tianmingjj.TianMingJJCursorManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_grid extends Sprite
   {
      
      private static const FIRST_EFF_ID:int = 35142;
      
      private var lockSprite:Sprite;
      
      private var lockBM:Bitmap;
      
      private var curVo:Vo_TianMing;
      
      private var upBM:Bitmap;
      
      private var upBMSpr:Sprite;
      
      public var upBtnVis:Boolean = true;
      
      private var eff:Effect;
      
      private var contentTF:MyTextField;
      
      public var grid:View_Grid;
      
      private var baseView:Sprite;
      
      public function Child_grid(type:int, bg:String)
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
         var color:String = null;
         this.disEff();
         this.grid.vo = vo;
         this.grid.gridId = gridId;
         this.curVo = vo;
         if(Boolean(vo) && Boolean(vo.str_name != "lock") && vo.str_name != null)
         {
            this.creatEff(vo);
         }
         if(Boolean(vo) && vo.color == 5)
         {
            if(!this.upBMSpr)
            {
               this.upBMSpr = new Sprite();
               this.upBM = new Bitmap();
               Utils.getLoadBitmap("resource/image/tianMing/Icon_TiShen.png",this.upBM);
               this.upBMSpr.addChild(this.upBM);
               this.baseView.addChild(this.upBMSpr);
               this.upBMSpr.x = 31;
               this.upBMSpr.y = 19;
               this.upBMSpr.buttonMode = true;
               this.upBMSpr.addEventListener(MouseEvent.CLICK,this.onUpHandle);
               TipManager.bind(this.upBMSpr,"点击升级帝阶天命");
            }
            this.upBMSpr.visible = true;
            this.baseView.addChild(this.upBMSpr);
         }
         else if(Boolean(this.upBMSpr))
         {
            this.upBMSpr.visible = false;
         }
         if(Boolean(vo) && Boolean(vo.str_name != "lock") && vo.str_name != null)
         {
            color = Model_shop.get_color_arr[vo.color - 1];
            this.contentTF.htmlText = vo.str_name + "<br>LV." + vo.level;
            if(vo.color > 2 || vo.level > 4)
            {
               if(!this.lockSprite)
               {
                  this.lockSprite = new Sprite();
                  this.lockBM = new Bitmap();
                  Utils.getLoadBitmap("resource/image/cast_lock/Locked2.png",this.lockBM);
                  this.lockSprite.addChild(this.lockBM);
                  this.baseView.addChild(this.lockSprite);
                  this.lockSprite.x = 30;
                  this.lockSprite.y = -6;
                  this.lockSprite.buttonMode = true;
                  this.lockSprite.addEventListener(MouseEvent.CLICK,this.onLockHandle);
                  TipManager.bind(this.lockSprite,"点击解锁天命");
               }
               this.lockSprite.visible = true;
               this.lockBM.bitmapData = null;
               if(vo.eat_lock)
               {
                  Utils.getLoadBitmap("resource/image/cast_lock/Locked2.png",this.lockBM);
                  TipManager.bind(this.lockSprite,"点击解锁天命");
               }
               else
               {
                  this.lockSprite.visible = false;
               }
               this.baseView.addChild(this.lockSprite);
            }
            else if(Boolean(this.lockSprite))
            {
               this.lockSprite.visible = false;
            }
         }
         else
         {
            this.contentTF.htmlText = "";
            if(Boolean(this.lockSprite))
            {
               this.lockSprite.visible = false;
            }
         }
      }
      
      private function onUpHandle(e:MouseEvent) : void
      {
         if(Model_Tianming.isLock)
         {
            return;
         }
         if(!this.upBtnVis)
         {
            UIManager.centerBroadcast.addMsg("请把冥级天命移入左侧天命背包后进行进阶操作",1);
            return;
         }
         e.stopImmediatePropagation();
         Model_TianmingJJ.currentUpSysId = this.curVo.id_server;
         TianmingJJCGMessage.CG_TMJJ_JJ(this.curVo.id_server);
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
            "y":36,
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
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function gridDownFun(event:MouseEvent) : void
      {
         UIManager.startDrag(event);
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         if(Boolean(this.curVo && Model_Tianming.isLock) && Boolean(!this.curVo.eat_lock) && (this.curVo.color > 2 || this.curVo.level > 4))
         {
            evt.stopImmediatePropagation();
            TianMingCGMessage.CG_TIANMING_LOCK(this.curVo.id_server,this.grid.type - 27);
            TianMingJJCursorManager.hide();
            Model_Tianming.isLock = false;
         }
         else
         {
            if(!(Boolean(this.curVo) && Boolean(this.curVo.color > 2) && this.curVo.level > 4))
            {
               if(Boolean(this.curVo) && Model_Tianming.isLock)
               {
                  UIManager.centerBroadcast.addMsg("此天命不需要加锁!");
               }
            }
            TianMingJJCursorManager.hide();
            Model_Tianming.isLock = false;
         }
      }
   }
}

