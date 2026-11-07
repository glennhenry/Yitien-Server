package com.yiTian.view.modules.role
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class View_role_meridian extends View_role_base
   {
      
      private var vec_meridian_id:Vector.<int>;
      
      private var vecMeridianItem:Vector.<MeridianItem>;
      
      private var sp:Sprite;
      
      private var leftBack:Bitmap;
      
      private var minLevel:int;
      
      private var nameArr:Array = [LangConfig.getWord("10000",1),LangConfig.getWord("10001",1),LangConfig.getWord("10002",1),LangConfig.getWord("10003",1),LangConfig.getWord("10004",1),LangConfig.getWord("10656",1),LangConfig.getWord("10657",1)];
      
      private var strVec:Vector.<String> = new Vector.<String>();
      
      private var effVec:Vector.<Effect>;
      
      private var colorVec:Vector.<ColorTransform>;
      
      private var effXY:Array = [[155,135],[138,187],[170,238],[138,290],[149,341],[140,393]];
      
      private var effKey:int = -1;
      
      private var eff:Bitmap;
      
      public function View_role_meridian()
      {
         super();
      }
      
      public static function getMaxLv() : uint
      {
         return GameUnitManager.hero.job >= 6 ? 15 : 10;
      }
      
      override public function Init() : void
      {
         var i:uint = 0;
         var meridian:MeridianItem = null;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":67,
            "width":416,
            "height":404
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":230,
            "y":75,
            "width":205,
            "height":374
         },Global.Img_Cdm);
         this.leftBack = new Bitmap();
         addChild(this.leftBack);
         this.vecMeridianItem = new Vector.<MeridianItem>();
         i = 0;
         while(i < 6)
         {
            meridian = new MeridianItem();
            meridian.x = 234;
            meridian.y = 77 + 62 * i;
            addChild(meridian);
            this.vecMeridianItem.push(meridian);
            i++;
         }
         this.sp = new Sprite();
         this.sp.graphics.beginFill(16777215,0);
         this.sp.graphics.drawRect(0,0,70,40);
         this.sp.graphics.endFill();
         addChild(this.sp);
         this.sp.buttonMode = true;
         this.sp.x = 35;
         this.sp.y = 85;
         this.sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
      }
      
      public function getNum(lv:int) : int
      {
         var r:int = 0;
         var id:int = 0;
         var src:Vector.<int> = CommandManager.get_vec_meridian();
         for each(id in src)
         {
            if(Data_lib.meridian[id][2] >= lv)
            {
               r += 1;
            }
         }
         return r;
      }
      
      public function getBoundary(minMerLv:int) : int
      {
         var key:String = null;
         var c:int = 0;
         var lv:int = 0;
         var dic:Dictionary = Data_lib.merLvAtb;
         for(key in dic)
         {
            c = int(key);
            if(c > lv && minMerLv >= c)
            {
               lv = c;
            }
         }
         return lv;
      }
      
      public function getMinLv() : int
      {
         var id:int = 0;
         var n:int = 0;
         var src:Vector.<int> = CommandManager.get_vec_meridian();
         if(!src)
         {
            return 0;
         }
         var c:int = 1000;
         for each(id in src)
         {
            n = int(Data_lib.meridian[id][2]);
            if(n < c)
            {
               c = n;
            }
         }
         return c;
      }
      
      protected function onRollOver(event:MouseEvent) : void
      {
         GameScene.upUILayer.addChild(UIManager.rolePanel.tip);
         this.sp.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      protected function onRollOut(e:MouseEvent) : void
      {
         this.sp.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         GameScene.upUILayer.removeChild(UIManager.rolePanel.tip);
      }
      
      private function getTipAtbStr(boundary:int, isCurLv:Boolean) : String
      {
         var data:Array = null;
         var infos:Array = Data_lib.merLvAtb[boundary];
         var datas:Array = Util.splicObj(infos[1],",_") as Array;
         var r:Array = [];
         for each(data in datas)
         {
            r.push(isCurLv ? "<font color=\'#9ADA78\' size=\'12\'> " + Data_lib.attribute[data[0]][0] + "+" + data[1] + "</font>" : "<font color=\'#999999\' size=\'12\'> " + Data_lib.attribute[data[0]][0] + "+" + data[1] + "</font>");
         }
         return r.join("\n");
      }
      
      protected function onMouseMove(e:MouseEvent) : void
      {
         this.strVec.splice(0,this.strVec.length);
         var minLv:int = this.getMinLv();
         var curBound:int = this.getBoundary(minLv);
         var nxtBound:int = int(Data_lib.merLvAtb[curBound][3]);
         if(curBound == 0)
         {
            this.strVec.push("<font color=\'#F9FF00\' size=\'16\'>" + LangConfig.getWord(Data_lib.merLvAtb[nxtBound][0],1) + "</font>");
            this.strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10005",1,nxtBound) + "</font>" + "</font><font color=\'#7CCCF2\' size=\'12\'>(" + this.getNum(nxtBound) + "/" + 6 + ")</font>\n" + this.getTipAtbStr(nxtBound,false));
         }
         else if(nxtBound != -1)
         {
            this.strVec.push("<font color=\'#F9FF00\' size=\'16\'>" + LangConfig.getWord(Data_lib.merLvAtb[nxtBound][0],1) + "</font>");
            this.strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10005",1,nxtBound) + "</font>" + "</font><font color=\'#7CCCF2\' size=\'12\'>(" + this.getNum(nxtBound) + "/" + 6 + ")</font>\n" + this.getTipAtbStr(nxtBound,false));
            this.strVec.push("<font color=\'#F9FF00\' size=\'16\'>" + LangConfig.getWord(Data_lib.merLvAtb[curBound][0],1) + "</font>");
            this.strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10005",1,curBound) + "</font>" + "<font color=\'#7CCCF2\'>" + LangConfig.getWord("60279",6) + "</font>\n" + this.getTipAtbStr(curBound,true));
         }
         else
         {
            this.strVec.push("<font color=\'#F9FF00\' size=\'16\'>" + LangConfig.getWord(Data_lib.merLvAtb[curBound][0],1) + "</font>");
            this.strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10005",1,curBound) + "</font>" + "<font color=\'#7CCCF2\'>" + LangConfig.getWord("60279",6) + "</font>\n" + this.getTipAtbStr(curBound,true));
         }
         UIManager.rolePanel.tip.updata(this,this.strVec);
         var stage:Stage = Global.stage;
         if(stage.mouseX + UIManager.rolePanel.tip.width > stage.stageWidth)
         {
            UIManager.rolePanel.tip.x = stage.mouseX - UIManager.rolePanel.tip.width - 10;
         }
         else
         {
            UIManager.rolePanel.tip.x = stage.mouseX + 10;
         }
         if(stage.mouseY + UIManager.rolePanel.tip.height > stage.stageHeight)
         {
            UIManager.rolePanel.tip.y = stage.stageHeight - UIManager.rolePanel.tip.height;
         }
         else
         {
            UIManager.rolePanel.tip.y = stage.mouseY;
         }
      }
      
      private function addEff() : void
      {
         var v:Vector.<int> = CommandManager.get_vec_meridian();
         if(!v)
         {
            return;
         }
         this.removeEff();
         if(!this.colorVec)
         {
            this.colorVec = new Vector.<ColorTransform>();
            this.colorVec.push(Util.qhtz0,Util.colorWhite,Util.qhtz1,Util.qhtz2,Util.qhtz3,Util.colorWhite2,Util.colorWhite);
         }
         this.effVec = new Vector.<Effect>();
         var i:uint = 0;
         while(i < 6)
         {
            if(Boolean(Data_lib.meridian[v[i]][MeridianItem.LEVEL]))
            {
               this.effVec[i] = EffectManager.addEffect("35033",this,1500,this.effXY[i][0],this.effXY[i][1],true);
            }
            else
            {
               this.effVec[i] = null;
            }
            i++;
         }
         var dic:Dictionary = Data_lib.meridian;
         i = 0;
         while(i < v.length)
         {
            if(Boolean(this.effVec[i]))
            {
               this.effVec[i].transform.colorTransform = this.colorVec[Data_lib.meridian[v[i]][MeridianItem.EFFCOLOR]];
            }
            i++;
         }
         var minLv:int = this.getMinLv();
         var curBound:int = this.getBoundary(minLv);
         var nowKey:int = int(Data_lib.merLvAtb[curBound][2]);
         if(nowKey != this.effKey)
         {
            if(Boolean(this.eff))
            {
               if(this.eff is Effect)
               {
                  EffectManager.removeEffect(this.eff as Effect);
               }
               else
               {
                  this.sp.removeChild(this.eff);
                  this.eff.bitmapData = null;
               }
            }
            if(nowKey == 0)
            {
               this.effKey = nowKey;
               this.eff = new Bitmap();
               this.sp.addChild(this.eff);
               Utils.loadTitle("lang/ch/Role_Imgs.swf","L_Ti",this.eff);
            }
            else
            {
               this.effKey = nowKey;
               this.eff = EffectManager.addEffect(this.effKey.toString(),this.sp,1000,35,20,true);
            }
         }
         this.setChildIndex(this.sp,this.numChildren - 1);
      }
      
      private function removeEff() : void
      {
         var i:uint = 0;
         if(Boolean(this.effVec))
         {
            i = 0;
            while(i < this.effVec.length)
            {
               if(Boolean(this.effVec[i]))
               {
                  EffectManager.removeEffect(this.effVec[i]);
               }
               i++;
            }
            this.effVec = null;
         }
      }
      
      public function update_attribute() : void
      {
         var minLv:int = this.getMinLv();
         this.vec_meridian_id = CommandManager.get_vec_meridian();
         this.reset();
      }
      
      public function update_bag() : void
      {
         this.vec_meridian_id = CommandManager.get_vec_meridian();
         this.reset();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            RoleCGMessage.CG_MERIDIAN_INIT();
            if(!this.leftBack.bitmapData)
            {
               Utils.loadTitle("lang/ch/Role_Imgs.swf","JingMai",this.leftBack,{
                  "x":38,
                  "y":96
               });
            }
            this.reset();
            this.addEff();
         }
         else
         {
            this.removeEff();
         }
      }
      
      public function reset() : void
      {
         var v:Vector.<int> = CommandManager.get_vec_meridian();
         if(!v)
         {
            return;
         }
         this.minLevel = Data_lib.meridian[v[0]][MeridianItem.LEVEL];
         var i:uint = 0;
         while(i < this.vecMeridianItem.length)
         {
            this.vecMeridianItem[i].id = v[i];
            if(Data_lib.meridian[v[i]][MeridianItem.LEVEL] < this.minLevel)
            {
               this.minLevel = Data_lib.meridian[v[i]][MeridianItem.LEVEL];
            }
            i++;
         }
         if(visible)
         {
            this.addEff();
         }
      }
      
      public function isCan() : Boolean
      {
         this.reset();
         var i:uint = 0;
         while(i < this.vecMeridianItem.length)
         {
            if(this.vecMeridianItem[i].isCan())
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function get needs() : Array
      {
         var mdItem:MeridianItem = null;
         var numArr:Array = [];
         var i:int = 0;
         while(i < this.vecMeridianItem.length)
         {
            mdItem = this.vecMeridianItem[i];
            numArr.push(mdItem.needNums);
            i++;
         }
         return numArr;
      }
   }
}

