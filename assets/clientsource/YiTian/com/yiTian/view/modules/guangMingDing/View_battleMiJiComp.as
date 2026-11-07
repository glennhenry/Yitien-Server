package com.yiTian.view.modules.guangMingDing
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.battle.HeadBuffIcon;
   import com.yiTian.view.modules.shenBing.View_ShenBingBufGrid;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingBattleBuff;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class View_battleMiJiComp extends Sprite
   {
      
      private var map:Object = {};
      
      private var arr:Array = [];
      
      public var itemWidth:Number = 21;
      
      public var sbMap:Object = {};
      
      private var _hasBattleEnd:Boolean = false;
      
      private var _bufferIconMap:Object = {};
      
      private var _bufferIconArr:Array = [];
      
      public function View_battleMiJiComp()
      {
         super();
      }
      
      public function setShenBingBuf(ids:Array) : void
      {
         var k:String = null;
         var i:int = 0;
         var sb:View_ShenBingBufGrid = null;
         var vo:Vo_ShenBingBattleBuff = null;
         if(Boolean(ids.length))
         {
            Utils.print("神兵buff:",ids);
         }
         for(k in this.sbMap)
         {
            sb = this.sbMap[k];
            removeChild(sb);
            sb.dispose();
            delete this.sbMap[k];
         }
         i = 0;
         while(i < ids.length)
         {
            sb = View_ShenBingBufGrid.getObj2();
            vo = new Vo_ShenBingBattleBuff();
            vo.id = ids[i][0];
            sb.vo = vo;
            addChild(sb);
            this.sbMap[vo.id] = sb;
            i += 1;
         }
         this.redraw();
      }
      
      public function addVo(vo:Vo_MiJi) : void
      {
         var g:View_MiJiGrid = null;
         g = this.map[vo.id];
         if(!g)
         {
            g = View_MiJiGrid.getObj();
            g.setBG(null);
            g._tfCount.visible = false;
            addChild(g);
            this.map[vo.id] = g;
            this.arr.push(g);
            vo.freeCount = -1;
            g.addEventListener(MouseEvent.MOUSE_MOVE,this.onGridMouseMove);
            g.addEventListener(MouseEvent.ROLL_OUT,this.onGridRollOut);
         }
         vo.size = 20;
         g.vo = vo;
         this.redraw();
         if(!this._hasBattleEnd)
         {
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.onBattleEnd);
            this._hasBattleEnd = true;
         }
      }
      
      public function setBuffers(buffers:Array) : void
      {
         var oldBufID:String = null;
         var data:Array = null;
         var bufID:String = null;
         for(oldBufID in this._bufferIconMap)
         {
            this.removeBufIcon(oldBufID);
            delete this._bufferIconMap[oldBufID];
         }
         for each(data in buffers)
         {
            bufID = data[0];
            this.addBufIcon(bufID);
         }
      }
      
      public function addBufIcon(bufID:String) : void
      {
         if(Data_lib.buffer[bufID][Vo_Buffer.BATTLE_ICON] == 0)
         {
            return;
         }
         if(Boolean(this._bufferIconMap[bufID]))
         {
            return;
         }
         var icon:HeadBuffIcon = HeadBuffIcon.getObj();
         icon.id = bufID;
         icon.load();
         addChild(icon);
         this._bufferIconMap[bufID] = icon;
         this._bufferIconArr.push(bufID);
         this.redraw();
      }
      
      public function removeBufIcon(bufID:String) : void
      {
         var ic:HeadBuffIcon = this._bufferIconMap[bufID];
         removeChild(ic);
         ic.dispose();
         delete this._bufferIconMap[bufID];
         this._bufferIconArr.splice(this._bufferIconArr.indexOf(bufID));
         this.redraw();
      }
      
      public function removeShenBing(sbId:int) : void
      {
         var k:String = null;
         var sb:View_ShenBingBufGrid = null;
         for(k in this.sbMap)
         {
            if(k == sbId.toString())
            {
               sb = this.sbMap[k];
               removeChild(sb);
               sb.dispose();
               delete this.sbMap[k];
               break;
            }
         }
         this.redraw();
      }
      
      public function clear() : void
      {
         var k:String = null;
         var grid:View_MiJiGrid = null;
         for(k in this.map)
         {
            grid = this.map[k];
            removeChild(grid);
            grid.dispose();
            delete this.map[k];
         }
         this.arr.splice(0);
      }
      
      public function clearShenBing() : void
      {
         var k:String = null;
         var sb:View_ShenBingBufGrid = null;
         for(k in this.sbMap)
         {
            sb = this.sbMap[k];
            removeChild(sb);
            sb.dispose();
            delete this.sbMap[k];
         }
      }
      
      public function clearBufIcon() : void
      {
         var k:String = null;
         var bufGrid:HeadBuffIcon = null;
         for(k in this._bufferIconMap)
         {
            bufGrid = this._bufferIconMap[k];
            removeChild(bufGrid);
            bufGrid.dispose();
            this._bufferIconArr.length = 0;
            delete this._bufferIconMap[k];
         }
      }
      
      private function onGridMouseMove(e:MouseEvent) : void
      {
         TipManager.update((e.target as View_MiJiGrid).vo);
      }
      
      private function onGridRollOut(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function onBattleEnd(o:*) : void
      {
         this.clear();
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.onBattleEnd);
         this._hasBattleEnd = false;
      }
      
      public function redraw() : void
      {
         addEventListener(Event.EXIT_FRAME,this.redraw1);
      }
      
      private function redraw1(e:Event) : void
      {
         var i:int = 0;
         var k:String = null;
         var o:DisplayObject = null;
         var of:int = 0;
         removeEventListener(e.type,this.redraw1);
         var len:int = int(this.arr.length);
         of = 0;
         for each(k in this._bufferIconArr)
         {
            o = this._bufferIconMap[k];
            o.x = of * this.itemWidth;
            of += 1;
         }
         i = 0;
         while(i < len)
         {
            o = this.arr[i];
            o.x = of * this.itemWidth;
            of += 1;
            i += 1;
         }
         for(k in this.sbMap)
         {
            o = this.sbMap[k];
            o.x = of * this.itemWidth;
            of += 1;
         }
      }
      
      public function addShenBing(id:int) : void
      {
         var xx:Number = NaN;
         var sb:View_ShenBingBufGrid = null;
         var vo:Vo_ShenBingBattleBuff = null;
         if(!this.sbMap[id])
         {
            xx = (this.arr.length + this.getShenBingLength()) * this.itemWidth;
            sb = View_ShenBingBufGrid.getObj2();
            vo = new Vo_ShenBingBattleBuff();
            vo.id = id;
            sb.vo = vo;
            this.sbMap[id] = sb;
            addChild(sb);
            this.redraw();
         }
      }
      
      public function getShenBingLength() : int
      {
         var k:String = null;
         var len:int = 0;
         for(k in this.sbMap)
         {
            len += 1;
         }
         return len;
      }
   }
}

