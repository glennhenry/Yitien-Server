package com.yiTian.view.modules.tianTi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianTiCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_xinFaPanel extends Panel
   {
      
      private var isLoad:Boolean = false;
      
      private var bg:ScaleBitmap;
      
      private var vec:Vector.<Child_xinFaBar>;
      
      private var xinFaCJ:Child_xinFaCJ;
      
      private var tf_curValue:MyTextField;
      
      private var bm_role:Bitmap;
      
      private var bm_bgg:Bitmap;
      
      private var mc_star:DisplayObject;
      
      private var sp_xfValueCon:Sprite;
      
      private var btn_roll:Button;
      
      private var btn_roll2:Button;
      
      private var tf:MyTextField;
      
      private var hasData:Boolean = true;
      
      private var eff:Effect;
      
      private var effSp:Sprite;
      
      private var _arr:Array;
      
      private var _type:int;
      
      private var _xinfa:uint;
      
      private var isFirstOpen:Boolean = true;
      
      private var bm1:Bitmap = new Bitmap();
      
      private var bm2:Bitmap = new Bitmap();
      
      private var isFirst:Boolean = true;
      
      public function View_xinFaPanel()
      {
         super();
         isTween = false;
      }
      
      override protected function initStaticView() : void
      {
         var y1:Number = NaN;
         var i:int = 0;
         var dir:Number = NaN;
         var _x:Number = NaN;
         var _y:Number = NaN;
         var b:Child_xinFaBar = null;
         super.initStaticView();
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":622,
            "height":424
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":574,
            "height":374
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":588,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.bm_bgg = new Bitmap();
         addChild(this.bm_bgg);
         this.sp_xfValueCon = new Sprite();
         this.sp_xfValueCon.x = 476;
         this.sp_xfValueCon.y = 60;
         this.sp_xfValueCon.graphics.beginFill(0,0);
         this.sp_xfValueCon.graphics.drawRect(0,0,75,60);
         this.sp_xfValueCon.graphics.endFill();
         TipManager.bind(this.sp_xfValueCon,Enum_ZhangMenRen.YJTIP);
         addChild(this.sp_xfValueCon);
         this.tf_curValue = ComponentUtil.getTextField("0",this.sp_xfValueCon,{
            "x":24,
            "y":7
         });
         this.tf = ComponentUtil.getTextField(LangConfig.getWord("21059",2,Enum_ZhangMenRen.YJCost.toString()),this,{
            "x":501,
            "y":103,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.bm_role = new Bitmap();
         this.bm_role.x = 252;
         this.bm_role.y = 18 + 196;
         addChild(this.bm_role);
         y1 = 247;
         this.vec = new Vector.<Child_xinFaBar>();
         var tmp:Array = [0,4,1,2,3];
         i = 0;
         while(i < 5)
         {
            dir = tmp[i] * Math.PI * 2 / 5;
            _x = Math.sin(dir) * 154;
            _y = -Math.cos(dir) * 95;
            b = new Child_xinFaBar();
            b.x = 277 + _x;
            b.y = y1 + _y;
            b.type = i + 1;
            addChild(b);
            this.vec.push(b);
            i += 1;
         }
         this.xinFaCJ = new Child_xinFaCJ();
         this.xinFaCJ.x = Enum_ZhangMenRen.CJX;
         this.xinFaCJ.y = Enum_ZhangMenRen.CJY;
         addChild(this.xinFaCJ);
      }
      
      private function creatTMBtn() : void
      {
         if(Boolean(this.eff))
         {
            return;
         }
         if(!this.effSp)
         {
            this.effSp = new Sprite();
            addChild(this.effSp);
            this.effSp.addEventListener(MouseEvent.CLICK,this.tmClickHd);
            this.effSp.buttonMode = true;
         }
         this.eff = EffectManager.addEffect("35121",this.effSp,1000,80,100,true);
      }
      
      private function removeTMEff() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
      }
      
      private function tmClickHd(e:MouseEvent) : void
      {
         View_TianMing.instance.visible = true;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      public function set CJEnable(value:Boolean) : void
      {
         this.rollEnable = value;
      }
      
      public function set xinFaInfo(arr:Array) : void
      {
         var xinFaInfo:Array;
         var maxCount:int;
         var k:int;
         var tmp:int = 0;
         var i:int = 0;
         while(i < 5)
         {
            this.vec[i].level = arr[i * 2];
            this.vec[i].exp = arr[i * 2 + 1];
            i += 1;
         }
         if(Boolean(Model_ZhangMenRen.isGod) && Boolean(this.tf) && Boolean(this.btn_roll2))
         {
            this.tf.text = LangConfig.getWord("21059",2,Enum_ZhangMenRen.YJCost.toString());
            TipManager.bind(this.btn_roll2,LangConfig.getWord("21062",2,Enum_ZhangMenRen.YJCost * Enum_ZhangMenRen.COMBOTIMES,Enum_ZhangMenRen.COMBOTIMES));
            i = 0;
            while(i < 5)
            {
               this.vec[i].updata();
               i += 1;
            }
         }
         xinFaInfo = Model_ZhangMenRen.xinFaInfo;
         if(!xinFaInfo)
         {
            return;
         }
         maxCount = 0;
         k = 0;
         while(k < xinFaInfo.length)
         {
            tmp = int(xinFaInfo[k * 2]);
            if(tmp == 100)
            {
               maxCount += 1;
            }
            k += 1;
         }
         if(maxCount >= 5)
         {
            if(!Model_ZhangMenRen.isGod)
            {
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_xinFaUpPanel.getInstance(),function():void
               {
                  if(Boolean(UIManager.xinFaPanel) && Boolean(UIManager.xinFaPanel.visible) && !hasData)
                  {
                     View_xinFaUpPanel.getInstance().visible = true;
                     hasData = true;
                  }
               });
            }
         }
      }
      
      private function onRoll(e:MouseEvent) : void
      {
         var xinFaInfo:Array = Model_ZhangMenRen.xinFaInfo;
         if(!xinFaInfo)
         {
            UIManager.centerBroadcast.addMsg("error msg");
            return;
         }
         if(this.checkXinFaLv())
         {
            return;
         }
         if(UIManager.xinFaPanel.curXinFa < Enum_ZhangMenRen.YJCost)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21058",2,Enum_ZhangMenRen.YJCost.toString()));
            return;
         }
         if(Model_ZhangMenRen.isGod)
         {
            TianTiCGMessage.CG_XINFACJ_GOD();
         }
         else
         {
            TianTiCGMessage.CG_XINFACJ();
         }
         UIManager.xinFaPanel.CJEnable = false;
      }
      
      private function onRoll2(e:MouseEvent) : void
      {
         if(this.checkXinFaLv())
         {
            return;
         }
         if(UIManager.xinFaPanel.curXinFa < Enum_ZhangMenRen.YJCost * Enum_ZhangMenRen.COMBOTIMES)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21058",2,(Enum_ZhangMenRen.YJCost * Enum_ZhangMenRen.COMBOTIMES).toString()));
            return;
         }
         if(Model_ZhangMenRen.isGod)
         {
            TianTiCGMessage.CG_XINFACJ2_GOD();
         }
         else
         {
            TianTiCGMessage.CG_XINFACJ2();
         }
         UIManager.xinFaPanel.CJEnable = false;
      }
      
      public function set rollEnable(value:Boolean) : void
      {
         this.btn_roll.enabled = value;
         this.btn_roll2.enabled = value;
      }
      
      public function startCJ2(arr:Array) : void
      {
         this._arr = arr;
         this._type = 2;
         this.step();
         this.xinFaCJ.shake();
      }
      
      private function step(... param) : void
      {
         var gains:Array = null;
         var i:int = 0;
         var gainValue:int = 0;
         var name:String = null;
         var result:Array = null;
         var info:Array = null;
         var j:int = 0;
         var sumValue:int = 0;
         var name2:String = null;
         var results:Array = this._arr[0];
         var infos:Array = this._arr[1];
         if(Boolean(Model_ZhangMenRen.comboGains) && Boolean(Model_ZhangMenRen.comboGains.length))
         {
            gains = Model_ZhangMenRen.comboGains.shift();
            i = 0;
            while(i < gains.length)
            {
               gainValue = int(gains[i]);
               if(gainValue > 0)
               {
                  name = Enum_ZhangMenRen.xinFaNames[i];
                  UIManager.selfBroadcast.addMsg(name + " + " + gainValue);
               }
               i += 1;
            }
         }
         if(Boolean(results.length))
         {
            result = results.shift();
            info = infos.shift();
            this.startCJ(result,info,3,0);
            if(!hasEventListener("end"))
            {
               addEventListener("end",this.step);
            }
         }
         else
         {
            if(hasEventListener("end"))
            {
               removeEventListener("end",this.step);
            }
            this.xinFaCJ.stopShake();
            this.CJEnable = true;
            j = 0;
            while(j < Model_ZhangMenRen.sums.length)
            {
               sumValue = int(Model_ZhangMenRen.sums[j]);
               name2 = Enum_ZhangMenRen.xinFaNames[j];
               UIManager.selfBroadcast.addMsg(name2 + LangConfig.getWord("60307",6) + sumValue);
               j += 1;
            }
            this.checkXinFaLv();
         }
      }
      
      public function startCJ(arr:Array, nxtInfo:Array, base:int, acc:int) : void
      {
         this.xinFaCJ.start(arr,nxtInfo,base,acc);
         this.checkXinFaLv();
      }
      
      public function set type(value:int) : void
      {
         this._type = value;
      }
      
      public function cjEnd(results:Array, nxtInfos:Array) : void
      {
         this.xinFaCJ.showCJEnd(results,nxtInfos);
         dispatchEvent(new Event("end"));
         if(this._type == 1)
         {
            this.CJEnable = true;
         }
      }
      
      public function set curXinFa(value:int) : void
      {
         this._xinfa = value;
         this.tf_curValue.htmlText = this._xinfa.toString();
      }
      
      public function get curXinFa() : int
      {
         return this._xinfa;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(this.isFirstOpen)
            {
               bind_target = Enum_explor.bind(Enum_explor.BTN_NEIGONG);
               this.isFirstOpen = false;
            }
            this.showQuestGuide();
            if(!TianTiManager.xfLoad)
            {
               this.load();
               TianTiManager.xfLoad = true;
               return;
            }
            this.creatTMBtn();
         }
         else
         {
            this.removeTMEff();
         }
         super.visible = value;
         if(value)
         {
            if(Model_ZhangMenRen.isGod)
            {
               TianTiCGMessage.CG_XINFA_GOD();
            }
            else
            {
               TianTiCGMessage.CG_XINFA();
            }
            this.checkXinFaLv();
         }
      }
      
      public function load() : void
      {
         var arr:Array;
         var hero:Hero = GameUnitManager.hero;
         var picId:int = 20000 + Enum_job.getBaseJob(hero.job) * 100 + hero.sex;
         Utils.getSwfBitmap("resource/pic_swf/" + picId.toString() + ".swf",this.bm_role);
         arr = [];
         arr.push(["lang/ch/xinFa.swf",function(info:Object):void
         {
            Enum_ZhangMenRen.srcDomain = info.applicationDomain;
         },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            onC();
            View_loading.instance.visible = false;
         });
         if(!this.bm1.bitmapData)
         {
            Utils.loadTitle("lang/ch/Challenge_Imgs.swf","XFIcon",this.bm1,null,this.sp_xfValueCon);
         }
         if(!this.bm2.bitmapData)
         {
            Utils.loadTitle("lang/ch/Challenge_Imgs.swf","XFIcon",this.bm2,{
               "x":476,
               "y":96
            },this);
         }
      }
      
      private function tfComp(tf:MyTextField) : void
      {
         if(tf.parent == this)
         {
            removeChild(tf);
         }
         tf.bold = false;
         tf.dispose();
      }
      
      public function showEffect(arr:Array, nxtInfos:Array) : void
      {
         var d:int;
         var i:int;
         var numArr:Array = null;
         var countArr:Array = null;
         var sIndex:int = 0;
         var dIndex:int = 0;
         var sx:Number = NaN;
         var sy:Number = NaN;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var sp:Sprite = null;
         var effect:Effect = null;
         var p:Number = NaN;
         var pi:Number = NaN;
         var time:Number = NaN;
         var rota:Number = NaN;
         numArr = [0,0,0,0,0];
         countArr = [0,0,0,0,0];
         var q:int = 0;
         while(q < numArr.length)
         {
            numArr[q] = 0;
            q += 1;
         }
         countArr = [0,0,0,0,0];
         d = 0;
         while(d < arr.length)
         {
            if(arr[d] > 0)
            {
               countArr[arr[d] - 1] += 1;
            }
            d += 1;
         }
         i = 0;
         while(i < arr.length)
         {
            if(arr[i] > 0)
            {
               sIndex = i;
               dIndex = arr[i] - 1;
               sx = 155 + Child_xinFaCJ.vecX[i];
               sy = 50 + Child_xinFaCJ.Y1 + 3 + 23;
               dx = this.vec[dIndex].x + 23;
               dy = this.vec[dIndex].y + 23;
               sp = new Sprite();
               var _temp_1:* = sp;
               sp.mouseChildren = false;
               _temp_1.mouseEnabled = false;
               effect = EffectManager.addEffect("35072",sp,1000,0,-40,true);
               p = (dy - sy) / (dx - sx);
               pi = Math.atan(p);
               time = Math.sqrt(Utils.dist(sx,sy,dx,dy)) * 6;
               if(this._type == 2)
               {
                  time *= 0.8;
               }
               rota = pi / Math.PI * 180;
               if(rota >= 0)
               {
                  rota -= 90;
               }
               else
               {
                  rota += 90;
               }
               sp.rotation = rota;
               sp.tabIndex = dIndex;
               addChild(sp);
               Tween.to(sp,time,{
                  "x":[sx,dx],
                  "y":[sy,dy]
               },function(target:Sprite):void
               {
                  var eff:Effect = null;
                  var gain:int = 0;
                  var tf:MyTextField = null;
                  if(Boolean(target.parent))
                  {
                     target.parent.removeChild(target);
                  }
                  while(Boolean(target.numChildren))
                  {
                     eff = target.getChildAt(0) as Effect;
                     EffectManager.removeEffect(eff);
                  }
                  EffectManager.addEffect("35073",UIManager.xinFaPanel,1000,target.x + 3,target.y + 3);
                  var idx:int = target.tabIndex;
                  numArr[idx] += 1;
                  if(numArr[idx] == countArr[idx])
                  {
                     if(countArr[idx] == 1)
                     {
                        gain = 100;
                     }
                     else
                     {
                        gain = 100 * Math.pow(2,countArr[idx] - 2);
                     }
                     if(_type == 1)
                     {
                        UIManager.selfBroadcast.addMsg(Enum_ZhangMenRen.xinFaNames[idx] + " + " + gain);
                     }
                     tf = ComponentUtil.getTextField(Enum_ZhangMenRen.xinFaNames[idx] + "+" + gain.toString(),UIManager.xinFaPanel,{
                        "bold":true,
                        "x":vec[idx].x + 20,
                        "y":vec[idx].y + 20
                     });
                     tf.color = Enum_ZhangMenRen.colorArr[idx];
                     Tween.to(tf,1500,{
                        "x":[tf.x,vec[idx].x + 10 + Math.random() * 20],
                        "y":[tf.y,vec[idx].y - 100]
                     },tfComp,null,Tween.SIN06);
                     vec[idx].level = nxtInfos[idx * 2];
                     vec[idx].exp = nxtInfos[idx * 2 + 1];
                  }
               },null,Tween.SIN);
            }
            i += 1;
         }
      }
      
      private function onC() : void
      {
         var i:int;
         Utils.loadTitle("lang/ch/Challenge_Imgs.swf","XF_Board",this.bm_bgg,{
            "x":31,
            "y":47
         },null);
         this.mc_star = new (Enum_ZhangMenRen.srcDomain.getDefinition("B3") as Class)();
         this.mc_star.x = 150;
         this.mc_star.y = 185;
         addChildAt(this.mc_star,getChildIndex(this.bm_bgg) + 1);
         i = 0;
         while(i < 5)
         {
            this.vec[i].init();
            i += 1;
         }
         this.xinFaCJ.init();
         this.visible = true;
         if(!this.btn_roll)
         {
            if(Boolean(Utils.swfPool["lang/ch/Challenge_Imgs.swf"]))
            {
               this.btn_roll = ComponentUtil.getButton("","Button_YaoJiang",this,{
                  "x":428,
                  "y":61,
                  "textColor":16184781
               },Utils.swfPool["lang/ch/Challenge_Imgs.swf"]);
               this.btn_roll2 = ComponentUtil.getButton("","Button_YJXF",this,{
                  "x":499,
                  "y":134,
                  "textColor":16184781
               },Utils.swfPool["lang/ch/Challenge_Imgs.swf"]);
               this.tt();
            }
            else
            {
               MassLoader.add("lang/ch/Challenge_Imgs.swf",function(info:Object):void
               {
                  if(Boolean(info.content))
                  {
                     btn_roll = ComponentUtil.getButton("","Button_YaoJiang",info.obj.parent,{
                        "x":428,
                        "y":61,
                        "textColor":16184781
                     },info.applicationDomain);
                     btn_roll2 = ComponentUtil.getButton("","Button_YJXF",info.obj.parent,{
                        "x":499,
                        "y":134,
                        "textColor":16184781
                     },info.applicationDomain);
                     Utils.swfPool[info.url] = info.applicationDomain;
                     tt();
                  }
               },null,MassLoader.LEVEL2,{"parent":this});
            }
         }
         Utils.loadTitle("lang/ch/Challenge_Imgs.swf","Title_XinFa",new Bitmap(),{
            "x":226,
            "y":5
         },this);
      }
      
      private function tt() : void
      {
         this.btn_roll.callBack = this.onRoll;
         this.btn_roll2.callBack = this.onRoll2;
         TipManager.bind(this.btn_roll,LangConfig.getWord("21056",2));
         TipManager.bind(this.btn_roll2,LangConfig.getWord("21062",2,Enum_ZhangMenRen.YJCost * Enum_ZhangMenRen.COMBOTIMES,Enum_ZhangMenRen.COMBOTIMES));
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
      
      public function showQuestGuide() : void
      {
         if(Model_quest.checkCurMainQStepType(Enum_quest_step_type.LENG_XINFA))
         {
            this.resetPosition();
            QuestGuiManager.addKuang(null,380,294,78,32);
            QuestGuiManager.addJian(this,500,80,180);
         }
      }
      
      public function showCloseGuide() : void
      {
         QuestGuiManager.addKuang(this,CloseButton.x - 5,CloseButton.y - 5,CloseButton.width + 10,CloseButton.height + 10);
         QuestGuiManager.addJian(this,CloseButton.width + CloseButton.x + 3,CloseButton.height / 2 + CloseButton.y,180);
      }
      
      public function updataUI() : void
      {
         var i:int = 0;
         if(Model_ZhangMenRen.isGod)
         {
            this.tf.text = LangConfig.getWord("21059",2,Enum_ZhangMenRen.YJCost.toString());
            TipManager.bind(this.btn_roll2,LangConfig.getWord("21062",2,Enum_ZhangMenRen.YJCost * Enum_ZhangMenRen.COMBOTIMES,Enum_ZhangMenRen.COMBOTIMES));
            i = 0;
            while(i < 5)
            {
               this.vec[i].updata();
               i += 1;
            }
            TianTiCGMessage.CG_XINFA_GOD();
         }
      }
      
      public function checkXinFaLv() : Boolean
      {
         var maxCount:int;
         var maxLvCount:int;
         var i:int;
         var tmp:int = 0;
         var xinFaInfo:Array = Model_ZhangMenRen.xinFaInfo;
         if(!xinFaInfo)
         {
            this.hasData = false;
            return false;
         }
         if(this.isFirst)
         {
            this.isFirst = false;
            this.tf.text = LangConfig.getWord("21059",2,Enum_ZhangMenRen.YJCost.toString());
         }
         maxCount = 0;
         maxLvCount = 0;
         i = 0;
         while(i < xinFaInfo.length)
         {
            tmp = int(xinFaInfo[i * 2]);
            if(tmp == 100)
            {
               maxCount += 1;
            }
            if(tmp == 150)
            {
               maxLvCount += 1;
            }
            i += 1;
         }
         if(maxCount >= 5)
         {
            if(!Model_ZhangMenRen.isGod)
            {
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_xinFaUpPanel.getInstance(),function():void
               {
                  View_xinFaUpPanel.getInstance().visible = true;
               });
            }
            return true;
         }
         if(maxLvCount >= 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21057",2));
            return true;
         }
         return false;
      }
   }
}

