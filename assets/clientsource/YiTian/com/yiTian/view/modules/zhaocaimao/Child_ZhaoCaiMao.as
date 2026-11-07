package com.yiTian.view.modules.zhaocaimao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_ZhaoCaiMao;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.ZhaoCaiMaoCGMessage;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class Child_ZhaoCaiMao extends Sprite
   {
      
      private var wy_btn:Button;
      
      private var flagTxt:MyTextField;
      
      private var _index:Number;
      
      private var ownerTxt:MyTextField;
      
      private var statusTxt:MyTextField;
      
      private var bm:Bitmap;
      
      private var flagCon:Sprite;
      
      private var mmParent:Sprite;
      
      private var effect:Effect;
      
      private var effect1:Effect;
      
      public function Child_ZhaoCaiMao()
      {
         super();
         this.init();
      }
      
      public function get index() : Number
      {
         return this._index;
      }
      
      public function set index(value:Number) : void
      {
         this._index = value;
      }
      
      private function init() : void
      {
         ComponentUtil.getBitmap("Back_MaoDiK",this,{
            "x":0,
            "y":0
         },Global.ZCLMdm);
         this.mmParent = new Sprite();
         this.addChild(this.mmParent);
         this.bm = new Bitmap();
         this.bm.x = 53;
         this.bm.y = 49;
         this.mmParent.addChild(this.bm);
         this.flagCon = new Sprite();
         this.addChild(this.flagCon);
         this.ownerTxt = ComponentUtil.getTextField("玩家大名六字",this,{
            "x":70,
            "y":21,
            "color":16776960,
            "size":12,
            "leading":0
         },TextAlign.CENTER);
         this.wy_btn = ComponentUtil.getButton("","Button_WeiYang",this,{
            "x":15,
            "y":131,
            "textColor":16771436,
            "callBack":this.onClick
         },Global.ZCLMdm);
         ComponentUtil.getTextField("帮Ta喂养  ",this,{
            "x":28,
            "y":136,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.statusTxt = ComponentUtil.getTextField("00/00",this,{
            "x":86,
            "y":136,
            "color":327424,
            "size":12,
            "leading":0
         });
      }
      
      public function set bmd(bmd:BitmapData) : void
      {
         this.bm.bitmapData = bmd;
      }
      
      private function onClick(e:MouseEvent) : void
      {
         ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_WEIYANG(this._index);
      }
      
      public function update(vo:Vo_ZhaoCaiMao) : void
      {
         var className:String = null;
         var bm:Bitmap = null;
         var tempIndex:int = 0;
         visible = true;
         this.ownerTxt.text = vo.roleName;
         this.statusTxt.text = vo.currentWY + "/" + vo.maxWY;
         TipManager.bind(this.mmParent,View_ZhaoCaiMao.vo);
         this.index = vo.roleID;
         var arr:Array = vo.index.split("");
         if(arr.indexOf(".") != -1)
         {
            tempIndex = arr.indexOf(".");
            arr = arr.slice(0,tempIndex);
         }
         var len:int = int(arr.length);
         var _x:Number = 68 - (len - 1) / 2 * 11;
         var i:int = 0;
         while(i < arr.length)
         {
            className = "_" + arr[i];
            bm = ComponentUtil.getBitmap(className,this.flagCon,{
               "x":_x + i * 11,
               "y":5
            },Global.ZCLMdm);
            i++;
         }
         if(vo.roleID == GameUnitManager.hero.id)
         {
            this.filters = [new GlowFilter(16646144,0.6,10,10,8,1)];
         }
         else
         {
            this.filters = [];
         }
      }
      
      public function eff() : void
      {
         var flag:int = 0;
         var flag1:int = 0;
         if(Boolean(this.effect))
         {
            return;
         }
         this.bm.visible = false;
         this.effect1 = EffectManager.addEffect("35167",this,2000,79,49,false);
         this.effect = EffectManager.addEffect("35327",this,800,79,85,true);
         flag = int(setTimeout(function():void
         {
            EffectManager.removeEffect(effect);
            bm.visible = true;
            clearTimeout(flag);
         },3000));
         flag1 = int(setTimeout(function():void
         {
            EffectManager.removeEffect(effect1);
            clearTimeout(flag1);
         },3000));
      }
      
      public function dispose() : void
      {
         this.wy_btn.enabled = true;
         visible = false;
         TipManager.unBind(this.mmParent);
         while(Boolean(this.flagCon.numChildren))
         {
            this.flagCon.removeChildAt(0);
         }
      }
   }
}

