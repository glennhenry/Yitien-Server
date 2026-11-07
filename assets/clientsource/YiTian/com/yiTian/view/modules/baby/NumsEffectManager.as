package com.yiTian.view.modules.baby
{
   import flash.display.DisplayObjectContainer;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public class NumsEffectManager
   {
      
      public static const BABY_STRENGTH:String = "baby_strength";
      
      public static var dataSdic:Dictionary = new Dictionary();
      
      public function NumsEffectManager()
      {
         super();
      }
      
      public static function addNums(value:int, dm:ApplicationDomain, sWid:uint, sHei:uint, totalWid:uint, _parent:DisplayObjectContainer, dataSc:Array, type_str:String) : void
      {
         var _numbers:Numbers = null;
         if(!dataSdic[type_str])
         {
            _numbers = new Numbers();
            _numbers.dm = dm;
            _numbers.sWid = sWid;
            _numbers.dataSc = dataSc;
            _numbers.init(totalWid,sHei + 4,_parent,value);
            dataSdic[type_str] = _numbers;
         }
         update(value,type_str);
      }
      
      public static function update(value:uint, typeStr:String) : void
      {
         var value_to_str:String = value.toString();
         var nowNumbers:Numbers = dataSdic[typeStr];
         nowNumbers.update(value);
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.utils.Tween;
import flash.display.Bitmap;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.system.ApplicationDomain;
import flash.utils.setTimeout;

class Numbers
{
   
   public var sWid:uint;
   
   public var sHei:uint;
   
   private var totalWidth:int;
   
   private var bmContainer:Sprite;
   
   private var containerSmask:Shape;
   
   public var dm:ApplicationDomain;
   
   public var lastValue:int;
   
   public var dataSc:Array;
   
   private var nowValue:int;
   
   private var nowList:Array = [];
   
   public function Numbers()
   {
      super();
   }
   
   public function init(wid:uint, hei:uint, _parent:DisplayObjectContainer, value:int) : void
   {
      this.bmContainer = new Sprite();
      this.bmContainer.graphics.beginFill(0,0);
      this.bmContainer.graphics.drawRect(0,0,wid,hei);
      this.bmContainer.graphics.endFill();
      this.containerSmask = ComponentUtil.getShape(wid,16,0,0);
      ComponentUtil.setPropertie(this.containerSmask,{"y":4});
      this.bmContainer.mask = this.containerSmask;
      _parent.addChild(this.bmContainer);
      _parent.addChild(this.containerSmask);
      this.sHei = hei;
      this.totalWidth = wid;
   }
   
   private function addUnit(count:int) : void
   {
      var sIner:Iners = null;
      var i:int = 0;
      while(i < count)
      {
         sIner = Iners.instance;
         sIner.init(this.sHei,0,this.dm,this.dataSc);
         this.bmContainer.addChild(sIner);
         this.nowList.unshift(sIner);
         i++;
      }
      this.resize();
   }
   
   private function removeUnit(count:int) : void
   {
      var sIner:Iners = null;
      var i:int = 0;
      while(i < count)
      {
         sIner = this.nowList.pop();
         sIner.dispose();
         if(this.bmContainer.contains(sIner))
         {
            this.bmContainer.removeChild(sIner);
         }
         i++;
      }
      this.resize();
   }
   
   public function update(value:int) : void
   {
      var valStr:String;
      var nowValStr:String;
      var res:int;
      var n:int = 0;
      if(this.nowValue == value)
      {
         return;
      }
      valStr = value.toString();
      nowValStr = this.nowValue.toString();
      res = valStr.length - nowValStr.length;
      if(this.nowValue == 0)
      {
         this.addUnit(valStr.length);
         n = int(setTimeout(function():void
         {
            run_now(value);
         },200));
      }
      else
      {
         if(res < 0)
         {
            this.removeUnit(-res);
         }
         else if(res > 0)
         {
            this.addUnit(res);
         }
         this.run_now(value);
      }
   }
   
   private function run_now(value:int) : void
   {
      var sIner:Iners = null;
      var nowN:int = 0;
      this.nowValue = value;
      var i:int = 0;
      while(i < this.nowList.length)
      {
         sIner = this.nowList[i];
         nowN = int(this.nowValue.toString().charAt(i));
         sIner.toNum = nowN;
         i++;
      }
   }
   
   private function resize() : void
   {
      var sIner:Iners = null;
      var i:int = 0;
      while(i < this.nowList.length)
      {
         sIner = this.nowList[i];
         ComponentUtil.setPropertie(sIner,{"x":this.sWid * i});
         i++;
      }
   }
}

class Iners extends Sprite
{
   
   private static var pool:Array = [];
   
   private var gapH:int;
   
   private var dm:ApplicationDomain;
   
   private var bmArr:Array = [];
   
   private var _toNum:int;
   
   public function Iners()
   {
      var b:Bitmap = null;
      super();
      var i:int = 0;
      while(i < 10)
      {
         b = new Bitmap();
         addChild(b);
         this.bmArr.push(b);
         i++;
      }
   }
   
   public static function get instance() : Iners
   {
      return pool.pop() || new Iners();
   }
   
   public function init(gapH:int, nowNum:int, dm:ApplicationDomain, arr:Array) : void
   {
      var i:int = 0;
      var b:Bitmap = null;
      this.gapH = gapH;
      this.dm = dm;
      i = 0;
      while(i < this.bmArr.length)
      {
         b = this.bmArr[i];
         b.bitmapData = ComponentUtil.getBitmapData(arr[i],dm);
         ComponentUtil.setPropertie(b,{"y":-gapH * i});
         i++;
      }
   }
   
   public function set toNum(value:int) : void
   {
      Tween.stop(this);
      this._toNum = value;
      var taY:int = int(this.bmArr[value].y);
      var dis:int = Math.abs(taY - this.y);
      Tween.to(this,dis * 5,{"y":[this.y,-taY]},null,null,Tween.BEE_LINE);
   }
   
   public function get toNum() : int
   {
      return this._toNum;
   }
   
   public function dispose() : void
   {
      var b:Bitmap = null;
      this.gapH = 0;
      pool.push(this);
      for each(b in this.bmArr)
      {
         b.bitmapData = null;
      }
   }
}
