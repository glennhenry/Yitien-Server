package com.yiTian.view.modules.tianTi
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianTiCGMessage;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Child_tianTi extends Sprite
   {
      
      private var nodes:Array = [];
      
      private var bg:Bitmap;
      
      private var container:Sprite;
      
      private var w:Number = 600;
      
      private var h:Number = 401;
      
      private var _mask:Shape;
      
      private var _pIndex:int;
      
      private var tmpx:Number;
      
      private var tmpy:Number;
      
      private var offsetX:Number = 222;
      
      private var offsetY:Number = 152;
      
      private var X1:Number = 55;
      
      private var Y1:Number = 380;
      
      public var isTween:Boolean = false;
      
      public function Child_tianTi()
      {
         super();
         this.container = new Sprite();
         addChild(this.container);
         graphics.beginFill(0,0.7);
         graphics.drawRect(0,0,this.w,this.h);
         graphics.endFill();
         this._mask = new Shape();
         this._mask.graphics.beginFill(0,0);
         this._mask.graphics.drawRect(0,0,this.w,this.h);
         addChild(this._mask);
         mask = this._mask;
         this.init();
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.onBPE);
      }
      
      public function stopIm() : void
      {
         Tween.stop(this.container);
      }
      
      private function onBPE(bId:int) : void
      {
         var p:Child_tianTiUnit = null;
         var gainXF:int = 0;
         var str:String = null;
         var arr:Array = TianTiManager.bInfo;
         if(!arr)
         {
            return;
         }
         var curLv:int = TianTiManager.curLv;
         var ttBattleResult:int = int(arr[0]);
         var ttBattleLv:int = int(arr[1]);
         var ttBattleId:int = int(arr[2]);
         if(bId == ttBattleId)
         {
            p = TianTiManager.player;
            if(ttBattleResult == 1)
            {
               this.tweenToNxt();
               if(TianTiManager.recordLv < ttBattleLv)
               {
                  TianTiManager.recordLv = ttBattleLv;
               }
               gainXF = int(arr[3]);
               str = LangConfig.getWord("29011",2,gainXF.toString());
               UIManager.centerBroadcast.addMsg(str,1);
               UIManager.selfBroadcast.addMsg(str);
            }
            else
            {
               this.resetP();
            }
            TianTiManager.bInfo = null;
            p.isTween = false;
            this.isTween = false;
         }
      }
      
      private function resetP() : void
      {
         var p:Child_tianTiUnit = null;
         p = TianTiManager.player;
         p.x = this.tmpx;
         p.y = this.tmpy;
         p.state = 0;
      }
      
      public function init() : void
      {
         var i:int = 0;
         var node:Child_tianTiNode = null;
         i = 0;
         while(i < Enum_ZhangMenRen.MAXTILE)
         {
            node = Child_tianTiNode.pop();
            node.visible = false;
            this.nodes.push(node);
            this.container.addChild(node);
            i += 1;
         }
         var p:Child_tianTiUnit = Child_tianTiUnit.pop();
         var hero:Hero = GameUnitManager.hero;
         p.modelId = 20000 + Enum_job.getBaseJob(hero.job) * 100 + hero.sex;
         p.type = Child_tianTiUnit.PLAYER;
         p.sex = hero.sex;
         p.job = hero.job;
         p.way = 1;
         p.weaponDir = hero.weapon.toString();
         p.wing = hero.wing;
         p.updateLayer();
         TianTiManager.player = p;
      }
      
      public function resetLayer() : void
      {
         var i:int = 0;
         var node:Child_tianTiNode = null;
         var lv:int = 0;
         if(!this.bg)
         {
            this.bg = new Bitmap();
            this.bg = ComponentUtil.getBitmap("Back_Challenge",null,null,Global.Challenge_Imgsdm);
            addChildAt(this.bg,0);
         }
         var curLv:int = TianTiManager.curLv;
         var maxLv:int = TianTiManager.maxLv;
         if(curLv == maxLv)
         {
            this.setPlayerIndex(1);
            while(i < Enum_ZhangMenRen.MAXTILE)
            {
               node = this.nodes[i];
               node.lv = lv;
               node.isShowNpc(false);
               i += 1;
            }
            this.nodes[0].visible = true;
            this.nodes[1].visible = true;
            this.resetNode();
            return;
         }
         while(i < Enum_ZhangMenRen.MAXTILE)
         {
            node = this.nodes[i];
            lv = curLv + i;
            node.lv = lv;
            node.isShowNpc(true);
            node.resetNpcModel();
            i += 1;
         }
         this.resetNode();
         if(curLv >= maxLv)
         {
            this.setPlayerIndex(1);
         }
         else
         {
            this.setPlayerIndex(0);
         }
      }
      
      public function setPlayerIndex(index:int) : void
      {
         this._pIndex = index;
         var p:Child_tianTiUnit = TianTiManager.player;
         this.nodes[index].addChild(p);
         this.nodes[index].isShowNpc(false);
      }
      
      public function getPlayerIndex() : int
      {
         return this._pIndex;
      }
      
      public function attToNxt() : void
      {
         var p:Child_tianTiUnit = TianTiManager.player;
         if(p.isTween)
         {
            return;
         }
         p.isTween = true;
         p.state = 1;
         this.tmpx = p.x;
         this.tmpy = p.y;
         Tween.to(p,500,{
            "x":[this.tmpx,this.tmpx + this.offsetX - 40],
            "y":[this.tmpy,this.tmpy - this.offsetY + 10]
         },this.onC1);
      }
      
      private function onC1() : void
      {
         var p:Child_tianTiUnit = TianTiManager.player;
         TianTiCGMessage.CG_TIANTIBATTLE(TianTiManager.curLv + 1);
      }
      
      public function tweenToNxt() : void
      {
         if(this.isTween)
         {
            return;
         }
         var node0:Child_tianTiNode = this.nodes[0];
         var lv0:int = node0.lv;
         var p:Child_tianTiUnit = TianTiManager.player;
         this.updatLayer1();
         this.resetNode();
         TianTiManager.curLv += 1;
         if(TianTiManager.curLv >= TianTiManager.maxLv)
         {
            this.setPlayerIndex(1);
            this.resetP();
            UIManager.tianTiPanel.updateInfo(-1);
            return;
         }
         var curLv:int = TianTiManager.curLv;
         this.nodes[1].addChild(TianTiManager.player);
         this.nodes[1].isShowNpc(false);
         this.isTween = true;
         TianTiManager.reqReward();
         Tween.to(this.container,500,{
            "x":[this.container.x,this.container.x - this.offsetX],
            "y":[this.container.y,this.container.y + this.offsetY]
         },this.onC,null,Tween.SIN);
      }
      
      private function onC() : void
      {
         this.nodes.push(this.nodes.shift());
         UIManager.tianTiPanel.updateInfo(TianTiManager.curLv);
      }
      
      private function updatLayer1() : void
      {
         var i:int = 0;
         var node:Child_tianTiNode = null;
         var curLv:int = TianTiManager.curLv;
         var maxLv:int = TianTiManager.maxLv;
         i = 0;
         while(i < Enum_ZhangMenRen.MAXTILE)
         {
            node = this.nodes[i];
            node.lv = i + curLv;
            node.isShowNpc(node.lv > curLv);
            node.visible = node.lv <= TianTiManager.maxLv;
            i += 1;
         }
      }
      
      public function resetNode() : void
      {
         var p:Child_tianTiUnit = null;
         var node:Child_tianTiNode = null;
         var nodeLv:int = 0;
         var curLv:int = 0;
         var maxLv:int = 0;
         p = TianTiManager.player;
         p.x = p.y = 0;
         p.state = 0;
         this.container.x = this.container.y = 0;
         var i:int = 0;
         while(i < this.nodes.length)
         {
            node = this.nodes[i];
            node.x = this.X1 + this.offsetX * i;
            node.y = this.Y1 - i * this.offsetY;
            node.parent.setChildIndex(node,1);
            nodeLv = node.lv;
            curLv = TianTiManager.curLv;
            maxLv = TianTiManager.maxLv;
            if(curLv >= maxLv)
            {
               if(i > 1)
               {
                  node.visible = false;
               }
            }
            else
            {
               if(node.lv > TianTiManager.maxLv)
               {
                  node.visible = false;
               }
               else
               {
                  node.visible = true;
               }
               if(node.lv > curLv)
               {
                  node.isShowNpc(true);
                  node.resetNpcModel();
               }
            }
            i += 1;
         }
         i = 3;
         while(i >= 0)
         {
            this.container.addChild(this.nodes[i]);
            i -= 1;
         }
      }
      
      public function initNodesBM() : void
      {
         var i:int = 0;
         while(i < this.nodes.length)
         {
            (this.nodes[i] as Child_tianTiNode).init();
            i += 1;
         }
      }
   }
}

