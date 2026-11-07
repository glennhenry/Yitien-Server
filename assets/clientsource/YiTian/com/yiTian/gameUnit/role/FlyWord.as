package com.yiTian.gameUnit.role
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class FlyWord extends Bitmap
   {
      
      public static const HURT:String = "hurt";
      
      public static const ADD_HP:String = "add_hp";
      
      public static const BAOJI:String = "baoji";
      
      public static const DODGE:String = "dodge";
      
      public static const GE_DANG:String = "ge_dang";
      
      public static const SKILL:String = "skill";
      
      public static const ADD_EXP:String = "add_exp";
      
      public static const POFANG:String = "pofang";
      
      public static const FU_MINGZHONG:String = "fumingzhong";
      
      public static const DRAWSKILLBABY:String = "skillBaby";
      
      private static var pool:Array = [];
      
      private static var lib:Dictionary = new Dictionary();
      
      private static var rect:Rectangle = new Rectangle(0,0,35,35);
      
      private var list:Array = [];
      
      private var initY:Number = -175;
      
      private var initWid:Number;
      
      private var initHei:Number;
      
      private var _colorTransform:ColorTransform;
      
      public function FlyWord()
      {
         super();
      }
      
      public static function getFlyWord() : FlyWord
      {
         return Boolean(pool.length) ? pool.pop() : new FlyWord();
      }
      
      public function init(text:String, type:String, initY:Number = -175) : void
      {
         this.list = [];
         this.initY = initY;
         this["draw_" + type](text);
         if(type == BAOJI)
         {
            if(int(text) > 0)
            {
               this.play_baoji_add();
            }
            else
            {
               this.play_baoji();
            }
         }
         else
         {
            this["play_" + type]();
         }
      }
      
      private function getRadom() : String
      {
         var arr:Array = ["hurt","add_hp","baoji","dodge","ge_dang","skill"];
         var rad:int = Utils.rnd(0,arr.length - 1);
         return arr[rad];
      }
      
      private function draw_hurt(num:String) : void
      {
         this.decode(Math.abs(int(num)));
         this.initWid = this.list.length * 24 + 24;
         this.initHei = 28;
         if(int(num) == 0)
         {
            this.list.push("0");
         }
         bitmapData = new BitmapData(this.list.length * 24 + 28,55,true,0);
         if(!lib["-"])
         {
            lib["-"] = ComponentUtil.getBitmapData("-",Global.battleDm);
         }
         Utils.point.x = 0;
         Utils.point.y = 0;
         rect.width = 24;
         rect.height = 28;
         bitmapData.copyPixels(lib["-"],rect,Utils.point,null,null,true);
         var j:int = this.list.length - 1;
         while(j >= 0)
         {
            if(!lib["r" + this.list[j]])
            {
               lib["r" + this.list[j]] = ComponentUtil.getBitmapData("r" + this.list[j],Global.battleDm);
            }
            Utils.point.x = (this.list.length - 1 - j) * 24 + 24;
            bitmapData.copyPixels(lib["r" + this.list[j]],rect,Utils.point,null,null,true);
            j--;
         }
      }
      
      private function draw_pofang(num:String) : void
      {
         var srcBmd:BitmapData = ComponentUtil.getBitmapData("pofang",Global.battleDm);
         bitmapData = new BitmapData(srcBmd.width,srcBmd.height,true,0);
         rect.width = srcBmd.width;
         rect.height = srcBmd.height;
         Utils.point.x = 0;
         Utils.point.y = 0;
         bitmapData.copyPixels(srcBmd,rect,Utils.point,null,null,true);
         this.initWid = bitmapData.width;
         this.initHei = bitmapData.height;
      }
      
      private function draw_fumingzhong(num:String) : void
      {
         var srcBmd:BitmapData = null;
         srcBmd = ComponentUtil.getBitmapData("fumingzhong",Global.battleDm);
         bitmapData = new BitmapData(srcBmd.width,srcBmd.height,true,0);
         rect.width = srcBmd.width;
         rect.height = srcBmd.height;
         Utils.point.x = 0;
         Utils.point.y = 0;
         bitmapData.copyPixels(srcBmd,rect,Utils.point,null,null,true);
         this.initWid = bitmapData.width;
         this.initHei = bitmapData.height;
      }
      
      private function draw_add_hp(num:String) : void
      {
         this.decode(Math.abs(int(num)));
         this.initWid = this.list.length * 24 + 24;
         this.initHei = 28;
         if(int(num) == 0)
         {
            this.list.push("0");
         }
         bitmapData = new BitmapData(this.list.length * 24 + 28,55,true,0);
         if(!lib["+"])
         {
            lib["+"] = ComponentUtil.getBitmapData("+",Global.battleDm);
         }
         Utils.point.x = 0;
         Utils.point.y = 0;
         rect.width = 24;
         rect.height = 28;
         bitmapData.copyPixels(lib["+"],rect,Utils.point,null,null,true);
         var j:int = this.list.length - 1;
         while(j >= 0)
         {
            if(!lib["r" + this.list[j]])
            {
               lib["r" + this.list[j]] = ComponentUtil.getBitmapData("r" + this.list[j],Global.battleDm);
            }
            Utils.point.x = (this.list.length - 1 - j) * 24 + 24;
            bitmapData.copyPixels(lib["r" + this.list[j]],rect,Utils.point,null,null,true);
            j--;
         }
      }
      
      private function draw_baoji(num:String) : void
      {
         this.decode(Math.abs(int(num)));
         this.initWid = this.list.length * 24 + 24 + 130;
         this.initHei = 70;
         if(int(num) == 0)
         {
            this.list.push("0");
         }
         bitmapData = new BitmapData(this.list.length * 24 + 24 + 130,70,true,0);
         if(!lib["baoji"])
         {
            lib["baoji"] = ComponentUtil.getBitmapData("baoji",Global.battleDm);
         }
         Utils.point.x = 0;
         Utils.point.y = 0;
         rect.width = 130;
         rect.height = 70;
         bitmapData.copyPixels(lib["baoji"],rect,Utils.point,null,null,true);
         var flag:String = int(num) > 0 ? "+" : "-";
         if(!lib[flag])
         {
            lib[flag] = ComponentUtil.getBitmapData(flag,Global.battleDm);
         }
         Utils.point.x = 130;
         Utils.point.y = 20;
         rect.width = 24;
         rect.height = 28;
         bitmapData.copyPixels(lib[flag],rect,Utils.point,null,null,true);
         var j:int = this.list.length - 1;
         while(j >= 0)
         {
            if(!lib["r" + this.list[j]])
            {
               lib["r" + this.list[j]] = ComponentUtil.getBitmapData("r" + this.list[j],Global.battleDm);
            }
            Utils.point.x = (this.list.length - 1 - j) * 24 + 24 + 130;
            bitmapData.copyPixels(lib["r" + this.list[j]],rect,Utils.point,null,null,true);
            j--;
         }
      }
      
      private function draw_dodge(num:String) : void
      {
         this.initWid = 75;
         this.initHei = 40;
         if(!lib["shanbi"])
         {
            lib["shanbi"] = ComponentUtil.getBitmapData("shanbi",Global.battleDm);
         }
         bitmapData = new BitmapData(75,40,true,0);
         Utils.point.x = 0;
         Utils.point.y = 0;
         rect.width = 75;
         rect.height = 40;
         bitmapData.copyPixels(lib["shanbi"],rect,Utils.point,null,null,true);
      }
      
      private function draw_ge_dang(num:String) : void
      {
         this.initWid = 75;
         this.initHei = 40;
         this.initY = -100;
         if(!lib["gedang"])
         {
            lib["gedang"] = ComponentUtil.getBitmapData("gedang",Global.battleDm);
         }
         bitmapData = new BitmapData(75,40,true,0);
         Utils.point.x = 0;
         Utils.point.y = 0;
         rect.width = 75;
         rect.height = 40;
         bitmapData.copyPixels(lib["gedang"],rect,Utils.point,null,null,true);
      }
      
      private function draw_skill(skillId:String) : void
      {
         this.initWid = 156;
         this.initHei = 38;
         this.initY = -200;
         bitmapData = new BitmapData(156,38,true,0);
         var levelUrl:String = "_L" + (int(skillId.charAt(2)) + 1);
         var skillUrl:String = "_" + skillId.substr(0,2) + "0" + skillId.substr(3,2);
         if(!lib[levelUrl])
         {
            lib[levelUrl] = ComponentUtil.getBitmapData(levelUrl,Global.battleDm);
         }
         Utils.point.x = 0;
         Utils.point.y = 0;
         rect.width = 78;
         rect.height = 38;
         bitmapData.copyPixels(lib[levelUrl],rect,Utils.point,null,null,true);
         if(!lib[skillUrl])
         {
            lib[skillUrl] = ComponentUtil.getBitmapData(skillUrl,Global.battleDm);
         }
         Utils.point.x = 78;
         bitmapData.copyPixels(lib[skillUrl],rect,Utils.point,null,null,true);
      }
      
      private function draw_skillBaby(skillId:String) : void
      {
         this.initWid = 136;
         this.initHei = 38;
         bitmapData = new BitmapData(156,38,true,0);
         Utils.point.x = 0;
         Utils.point.y = 0;
         rect.width = 156;
         rect.height = 38;
         var skillUrl:String = "_" + skillId;
         if(!lib[skillUrl])
         {
            lib[skillUrl] = ComponentUtil.getBitmapData(skillUrl,Global.battleDm);
         }
         bitmapData.copyPixels(lib[skillUrl],rect,Utils.point,null,null,true);
      }
      
      private function play_skillBaby() : void
      {
         Tween.to(this,200,{
            "x":[-this.initWid * 0.4 / 2,-this.initWid * 1.2 / 2],
            "y":[this.initY + 15,this.initY - this.initHei * 0.2],
            "scaleX":[0.4,1.2],
            "scaleY":[0.4,1.2],
            "alpha":[0.2,1]
         },this.skill1);
      }
      
      private function draw_add_exp(num:String) : void
      {
      }
      
      private function play_hurt() : void
      {
         Tween.to(this,150,{
            "x":[-this.initWid * 0.4 / 2,-this.initWid / 2],
            "y":[this.initY + 40,this.initY],
            "scaleX":[0.4,1],
            "scaleY":[0.4,1],
            "redOffset":[0,255],
            "greenOffset":[0,255],
            "blueOffset":[0,255],
            "alpha":[0,1]
         },this.hurt1);
      }
      
      private function play_pofang() : void
      {
         Tween.to(this,150,{
            "x":[-this.initWid * 0.4 / 2,-this.initWid * 0.7 / 2],
            "y":[this.initY + 40,this.initY + this.initHei * 0.2],
            "scaleX":[0.4,0.7],
            "scaleY":[0.4,0.7],
            "redOffset":[0,240],
            "greenOffset":[0,190],
            "redOffset":[0,240],
            "alpha":[0.4,0.7]
         },this.hurt1);
      }
      
      private function play_fumingzhong() : void
      {
         Tween.to(this,150,{
            "x":[-this.initWid * 0.4 / 2,-this.initWid * 0.7 / 2],
            "y":[this.initY + 40,this.initY + this.initHei * 0.2],
            "scaleX":[0.4,0.7],
            "scaleY":[0.4,0.7],
            "redOffset":[0,240],
            "greenOffset":[0,190],
            "redOffset":[0,240],
            "alpha":[0.4,0.7]
         },this.hurt1);
      }
      
      private function fuEff() : void
      {
      }
      
      private function hurt1() : void
      {
         Tween.to(this,60,{
            "x":[-this.initWid / 2,-this.initWid * 0.8 / 2],
            "y":[this.initY,this.initY + this.initWid * 0.1],
            "scaleX":[1,0.8],
            "scaleY":[1,0.8],
            "redOffset":[255,0],
            "greenOffset":[255,0],
            "blueOffset":[255,0]
         },this.hurt2);
      }
      
      private function hurt2() : void
      {
         Tween.to(this,400,null,this.hurt3);
      }
      
      private function hurt3() : void
      {
         Tween.to(this,120,{
            "x":[-this.initWid * 0.8 / 2,-this.initWid * 0.4 / 2],
            "y":[this.initY + this.initWid * 0.1,this.initY + 30],
            "scaleX":[0.8,0.4],
            "scaleY":[0.8,0.4],
            "alpha":[1,0]
         },this.dispose);
      }
      
      private function play_add_hp() : void
      {
         this.redOffset = -150;
         this.greenOffset = 150;
         this.blueOffset = 0;
         Tween.to(this,150,{
            "x":[-this.initWid * 0.4 / 2,-this.initWid / 2],
            "y":[this.initY + 40,this.initY],
            "scaleX":[0.4,1],
            "scaleY":[0.4,1],
            "redOffset":[-150,255],
            "greenOffset":[150,255],
            "blueOffset":[0,255],
            "alpha":[0,1]
         },this.add_hp1);
      }
      
      private function add_hp1() : void
      {
         Tween.to(this,60,{
            "x":[-this.initWid / 2,-this.initWid * 0.8 / 2],
            "y":[this.initY,this.initY + this.initWid * 0.1],
            "scaleX":[1,0.8],
            "scaleY":[1,0.8],
            "redOffset":[255,-150],
            "greenOffset":[255,150],
            "blueOffset":[255,0]
         },this.add_hp2);
      }
      
      private function add_hp2() : void
      {
         Tween.to(this,400,null,this.add_hp3);
      }
      
      private function add_hp3() : void
      {
         Tween.to(this,150,{
            "x":[-this.initWid * 0.8 / 2,-this.initWid * 0.6 / 2],
            "y":[this.initY + this.initWid * 0.2,this.initY - 10],
            "scaleX":[0.8,0.6],
            "scaleY":[0.8,0.6],
            "alpha":[1,0]
         },this.dispose);
      }
      
      private function play_baoji() : void
      {
         Tween.to(this,120,{
            "x":[-this.initWid * 0.4 / 2,-this.initWid * 0.7 / 2],
            "y":[this.initY + 40,this.initY + this.initHei * 0.2],
            "scaleX":[0.4,0.7],
            "scaleY":[0.4,0.7],
            "greenOffset":[0,190],
            "redOffset":[0,240],
            "alpha":[0.4,0.7]
         },this.baoji1);
      }
      
      private function baoji1() : void
      {
         Tween.to(this,60,{
            "x":[-this.initWid * 0.7 / 2,-this.initWid * 0.6 / 2],
            "y":[this.initY + this.initHei * 0.3,this.initY + this.initHei * 0.4],
            "scaleX":[0.7,0.6],
            "scaleY":[0.7,0.6],
            "redOffset":[240,120],
            "greenOffset":[190,100],
            "alpha":[0.8,0.9]
         },this.baoji2);
      }
      
      private function baoji2() : void
      {
         Tween.to(this,90,{
            "x":[-this.initWid * 0.6 / 2,-this.initWid / 2],
            "y":[this.initY + this.initHei * 0.4,this.initY],
            "scaleX":[0.6,1],
            "scaleY":[0.6,1],
            "alpha":[0.9,1],
            "redOffset":[120,0],
            "greenOffset":[100,0]
         },this.baoji3);
      }
      
      private function baoji3() : void
      {
         Tween.to(this,400,null,this.baoji4);
      }
      
      private function baoji4() : void
      {
         Tween.to(this,120,{
            "x":[-this.initWid / 2,-this.initWid * 0.3 / 2],
            "y":[this.initY,this.initY + 40],
            "alpha":[1,0.3],
            "scaleX":[1,0.3],
            "scaleY":[1,0.3]
         },this.dispose);
      }
      
      private function play_baoji_add() : void
      {
         this.redOffset = -150;
         this.greenOffset = 150;
         this.blueOffset = 0;
         Tween.to(this,120,{
            "x":[-this.initWid * 0.4 / 2,-this.initWid * 0.7 / 2],
            "y":[this.initY + 40,this.initY + this.initHei * 0.2],
            "scaleX":[0.4,0.7],
            "scaleY":[0.4,0.7],
            "redOffset":[-150,255],
            "greenOffset":[150,255],
            "blueOffset":[0,255],
            "alpha":[0.4,0.7]
         },this.baoji_add1);
      }
      
      private function baoji_add1() : void
      {
         Tween.to(this,60,{
            "x":[-this.initWid * 0.7 / 2,-this.initWid * 0.6 / 2],
            "y":[this.initY + this.initHei * 0.3,this.initY + this.initHei * 0.4],
            "scaleX":[0.7,0.6],
            "scaleY":[0.7,0.6],
            "alpha":[0.8,0.9],
            "redOffset":[255,-78],
            "greenOffset":[255,189],
            "blueOffset":[255,-30]
         },this.baoji_add2);
      }
      
      private function baoji_add2() : void
      {
         Tween.to(this,90,{
            "x":[-this.initWid * 0.6 / 2,-this.initWid / 2],
            "y":[this.initY + this.initHei * 0.4,this.initY],
            "scaleX":[0.6,1],
            "scaleY":[0.6,1],
            "alpha":[0.9,1]
         },this.baoji_add3);
      }
      
      private function baoji_add3() : void
      {
         Tween.to(this,400,null,this.baoji_add4);
      }
      
      private function baoji_add4() : void
      {
         Tween.to(this,120,{
            "x":[-this.initWid / 2,-this.initWid * 0.3 / 2],
            "y":[this.initY,this.initY + 40],
            "alpha":[1,0.3],
            "scaleX":[1,0.3],
            "scaleY":[1,0.3]
         },this.dispose);
      }
      
      private function play_dodge() : void
      {
         Tween.to(this,150,{
            "x":[-70,-this.initWid * 0.8 / 2],
            "y":[this.initY + this.initHei * 0.5,this.initY + this.initHei * 0.2],
            "scaleX":[0.4,0.8],
            "scaleY":[0.4,0.8],
            "greenOffset":[0,90],
            "blueOffset":[0,255],
            "alpha":[0.6,0.8]
         },this.dodge1);
      }
      
      private function dodge1() : void
      {
         Tween.to(this,60,{
            "x":[-this.initWid * 0.8 / 2,-this.initWid * 0.7 / 2],
            "y":[this.initY + this.initHei * 0.2,this.initY + this.initHei * 0.3],
            "scaleX":[0.8,0.7],
            "scaleY":[0.8,0.7],
            "greenOffset":[90,40],
            "blueOffset":[255,120],
            "alpha":[0.8,0.9]
         },this.dodge2);
      }
      
      private function dodge2() : void
      {
         Tween.to(this,90,{
            "x":[-this.initWid * 0.7 / 2,-this.initWid / 2],
            "y":[this.initY + this.initHei * 0.3,this.initY],
            "scaleX":[0.7,1],
            "scaleY":[0.7,1],
            "alpha":[0.9,1],
            "greenOffset":[40,0],
            "blueOffset":[120,0]
         },this.dodge3);
      }
      
      private function dodge3() : void
      {
         Tween.to(this,300,null,this.dodge4);
      }
      
      private function dodge4() : void
      {
         Tween.to(this,120,{
            "x":[-this.initWid / 2,50],
            "y":[this.initY,this.initY + this.initHei * 0.6],
            "alpha":[1,0.3],
            "scaleX":[1,0.3],
            "scaleY":[1,0.3]
         },this.dispose);
      }
      
      private function play_ge_dang() : void
      {
         Tween.to(this,120,{
            "x":[-60,-this.initWid * 0.8 / 2],
            "y":[this.initY - 25,this.initY + this.initHei * 0.2],
            "scaleX":[0.4,0.8],
            "scaleY":[0.4,0.8],
            "greenOffset":[0,180],
            "redOffset":[0,90],
            "alpha":[0.4,0.8]
         },this.ge_dang1);
      }
      
      private function ge_dang1() : void
      {
         Tween.to(this,60,{
            "x":[-this.initWid * 0.8 / 2,-this.initWid * 0.6 / 2],
            "y":[this.initY + this.initHei * 0.2,this.initY + this.initHei * 0.3],
            "scaleX":[0.8,0.7],
            "scaleY":[0.8,0.7],
            "redOffset":[90,40],
            "greenOffset":[180,90],
            "alpha":[0.8,0.9]
         },this.ge_dang2);
      }
      
      private function ge_dang2() : void
      {
         Tween.to(this,90,{
            "x":[-this.initWid * 0.6 / 2,-this.initWid / 2],
            "y":[this.initY + this.initHei * 0.3,this.initY],
            "scaleX":[0.7,1],
            "scaleY":[0.7,1],
            "alpha":[0.9,1],
            "redOffset":[40,0],
            "greenOffset":[90,0]
         },this.ge_dang3);
      }
      
      private function ge_dang3() : void
      {
         Tween.to(this,300,null,this.ge_dang4);
      }
      
      private function ge_dang4() : void
      {
         Tween.to(this,120,{
            "x":[-this.initWid / 2,50],
            "y":[this.initY,this.initY + 40],
            "alpha":[1,0.3],
            "scaleX":[1,0.3],
            "scaleY":[1,0.3]
         },this.dispose);
      }
      
      private function play_skill() : void
      {
         Tween.to(this,200,{
            "x":[-this.initWid * 0.4 / 2,-this.initWid * 1.2 / 2],
            "y":[this.initY + 15,this.initY - this.initHei * 0.2],
            "scaleX":[0.4,1.2],
            "scaleY":[0.4,1.2],
            "alpha":[0.2,1]
         },this.skill1);
      }
      
      private function skill1() : void
      {
         Tween.to(this,90,{
            "x":[-this.initWid * 1.2 / 2,-this.initWid / 2],
            "y":[this.initY - this.initHei * 0.2,this.initY],
            "scaleX":[1.2,1],
            "scaleY":[1.2,1]
         },this.skill2);
      }
      
      private function skill2() : void
      {
         Tween.to(this,500,null,this.skill3);
      }
      
      private function skill3() : void
      {
         Tween.to(this,150,{
            "y":[this.initY,this.initY - 8],
            "alpha":[1,0]
         },this.dispose);
      }
      
      private function play_add_exp() : void
      {
      }
      
      private function decode(number:int) : void
      {
         if(number == 0)
         {
            return;
         }
         this.list.push(number % 10);
         this.decode(int(number / 10));
      }
      
      public function get colorTransform() : ColorTransform
      {
         return transform.colorTransform;
      }
      
      public function get redOffset() : int
      {
         return transform.colorTransform.redOffset;
      }
      
      public function get greenOffset() : int
      {
         return transform.colorTransform.greenOffset;
      }
      
      public function get blueOffset() : int
      {
         return transform.colorTransform.blueOffset;
      }
      
      public function set redOffset(value:int) : void
      {
         if(!this._colorTransform)
         {
            this._colorTransform = new ColorTransform();
         }
         this._colorTransform.redOffset = value;
         transform.colorTransform = this._colorTransform;
      }
      
      public function set greenOffset(value:int) : void
      {
         if(!this._colorTransform)
         {
            this._colorTransform = new ColorTransform();
         }
         this._colorTransform.greenOffset = value;
         transform.colorTransform = this._colorTransform;
      }
      
      public function set blueOffset(value:int) : void
      {
         if(!this._colorTransform)
         {
            this._colorTransform = new ColorTransform();
         }
         this._colorTransform.blueOffset = value;
         transform.colorTransform = this._colorTransform;
      }
      
      private function dispose() : void
      {
         parent.removeChild(this);
         if(this.blueOffset != 0)
         {
            this.blueOffset = 0;
         }
         if(this.greenOffset != 0)
         {
            this.greenOffset = 0;
         }
         if(this.redOffset != 0)
         {
            this.redOffset = 0;
         }
         this.bitmapData.dispose();
         this.alpha = 1;
         this.initY = -175;
         pool.push(this);
      }
      
      private function start() : void
      {
         Tween.to(this,150,{
            "y":[-120,-180],
            "scaleX":[0.5,1.2],
            "scaleY":[0.5,1.2],
            "alpha":[0.7,1]
         },this.step2);
      }
      
      private function step2() : void
      {
         Tween.to(this,150,{
            "y":[-180,-160],
            "scaleX":[1.2,1],
            "scaleY":[1.2,1]
         },this.step3);
      }
      
      private function step3() : void
      {
         Tween.to(this,200,{"y":[-160,-160]},this.step4);
      }
      
      private function step4() : void
      {
         Tween.to(this,300,{"alpha":[1,0]},this.step5);
      }
      
      private function step5() : void
      {
         this.dispose();
      }
   }
}

