package com.yiTian.view.modules.role
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HumanCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.cast.baishiZengyi.BaoSZYTip;
   import com.yiTian.view.modules.cast.baishiZengyi.Vo_baoshiZY;
   import com.yiTian.view.modules.chat.EffecObj;
   import com.yiTian.view.modules.chat.View_ChatPanel;
   import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.yellowDiamond.Model_init;
   import com.yiTian.view.modules.zhuanZhi.View_ZhuanZhiAtbSp;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_role_equip extends View_role_base
   {
      
      private static var INTERVALFRAM:int;
      
      private static var INTERVALFRAM2:int;
      
      private static var INTERVALFRAM3:int;
      
      private static const LEN_GRID:int = 11;
      
      private static const ARR_POS:Array = [[260,139],[44,139],[44,233],[44,280],[44,92],[44,186],[260,186],[260,92],[260,233],[260,280],[44,327],[260,327],[200.5,115]];
      
      private static const LEN_ATTRIBUTE:int = 16;
      
      public static const V1:int = 5;
      
      public static const V2:int = 7;
      
      public static const V3:int = 9;
      
      public static const V4:int = 11;
      
      public static const EFF:int = 3;
      
      public static const vecColor:Vector.<int> = new <int>[1,5,7,8,3];
      
      public static const TITLE:int = 0;
      
      public static const COLOR:int = 1;
      
      public static const YELI:int = 2;
      
      public static const DATA:int = 3;
      
      private const WIDTH:int = 122;
      
      private const HEIGHT:int = 15;
      
      private var vec_attribute:Vector.<int>;
      
      private var vec_str_attribute:Vector.<String>;
      
      private var tf_name:MyTextField;
      
      private var tf_hp:MyTextField;
      
      private var tf_mp:MyTextField;
      
      private var bmp_head:Bitmap;
      
      private var hpBM:Bitmap;
      
      private var hpMask:Shape;
      
      private var mpBM:Bitmap;
      
      private var mpMask:Shape;
      
      private var vec_tf:Vector.<MyTextField>;
      
      private var vec_grids:Vector.<View_Grid>;
      
      private var vec_Vo_equip_cache:Vector.<Vo_equip>;
      
      public var pin_jie:Array = [[LangConfig.getWord("10009",1),0]];
      
      private var txtChengHao:MyTextField;
      
      private var btnChengHao:Button;
      
      private var TipChengHaoSpr:Sprite;
      
      private var sp:Sprite;
      
      private var effLevel:Sprite;
      
      private var containers_move:Sprite;
      
      private var backRoleBmp:Bitmap;
      
      private var baoshiZY:BaoSZYTip;
      
      private var jobExtraAtbSp:View_ZhuanZhiAtbSp;
      
      private var hlSP:ringSP;
      
      private var effVec:Vector.<Effect> = new Vector.<Effect>(12);
      
      private var _info3:Object;
      
      private var _info2:Object;
      
      private var _info:Object;
      
      private var imgList:Vector.<BitmapData>;
      
      private var imgListZM:Vector.<BitmapData>;
      
      private var imgList2:Vector.<BitmapData>;
      
      private var imgList2ZM:Vector.<BitmapData>;
      
      private var imgList3:Vector.<BitmapData>;
      
      private var playBody:int;
      
      private var playWeapon:int;
      
      private var playhorse:int;
      
      private var bmpbody:Bitmap;
      
      private var bmpWeapon:Bitmap;
      
      private var bmpHorse:Bitmap;
      
      private var playIndexBody:int;
      
      private var playIndexWeapon:int;
      
      private var playIndexHorse:int;
      
      private var tstTF:MyTextField;
      
      private var _levelTen:int;
      
      private var _levelSix:int;
      
      private var _levelSixNums:int;
      
      private var _level:int;
      
      private var _nums:int;
      
      private var isFirstOpen:Boolean = true;
      
      private var idStr:String;
      
      private var eff1:Effect;
      
      private var eff2:Effect;
      
      private var effIcon:Bitmap;
      
      private var hpBGBM:Bitmap;
      
      private var mpBGBM:Bitmap;
      
      private var vecEffId:Vector.<String> = new <String>["35077","35078","35079"];
      
      private var arrNextCH:Array = [];
      
      public function View_role_equip()
      {
         super();
      }
      
      override public function Init() : void
      {
         var txtHP:MyTextField;
         var txtMP:MyTextField;
         var txtY:Array;
         var tf:MyTextField = null;
         var i:int = 0;
         var grid:View_Grid = null;
         dis_bg = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":67,
            "width":416,
            "height":389
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":314,
            "y":72,
            "width":126,
            "height":379
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":317,
            "y":388,
            "width":120,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":317,
            "y":248,
            "width":120,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":317,
            "y":108,
            "width":120,
            "height":2
         },Global.Img_Cdm);
         this.bmp_head = new Bitmap();
         addChild(this.bmp_head);
         this.bmp_head.x = 39;
         this.bmp_head.y = 76;
         this.bmp_head.visible = false;
         this.backRoleBmp = new Bitmap();
         addChild(this.backRoleBmp);
         Utils.getLoadBitmap("resource/image/role/roleBack.jpg",this.backRoleBmp,{
            "x":39,
            "y":76
         },function():void
         {
            setChildIndex(backRoleBmp,2);
         });
         this.effLevel = new Sprite();
         addChild(this.effLevel);
         this.sp = new Sprite();
         this.sp.graphics.beginFill(0,0);
         this.sp.graphics.drawRect(0,0,40,40);
         this.sp.graphics.endFill();
         addChild(this.sp);
         this.sp.x = 243 - 17;
         this.sp.y = 385 + 13;
         this.containers_move = new Sprite();
         this.containers_move.graphics.beginFill(0,0);
         this.containers_move.graphics.drawRect(0,0,132,130);
         this.containers_move.graphics.endFill();
         addChild(this.containers_move);
         this.containers_move.x = 191;
         this.containers_move.y = 288;
         this.containers_move.alpha = 0.8;
         this.bmpHorse = new Bitmap();
         this.bmpWeapon = new Bitmap();
         this.bmpbody = new Bitmap();
         this.containers_move.addChild(this.bmpHorse);
         this.containers_move.addChild(this.bmpWeapon);
         this.containers_move.addChild(this.bmpbody);
         this.containers_move.mouseChildren = false;
         this.containers_move.mouseEnabled = false;
         mouseEnabled = false;
         this.sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.effIcon = new Bitmap();
         this.sp.addChild(this.effIcon);
         this.txtChengHao = ComponentUtil.getTextField("",this,{
            "x":320,
            "y":77,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.hpBGBM = new Bitmap();
         addChild(this.hpBGBM);
         this.hpBGBM.x = 94;
         this.hpBGBM.y = 388;
         this.hpBM = new Bitmap();
         this.hpBM.x = 95;
         this.hpBM.y = 390 + 14;
         addChild(this.hpBM);
         this.hpMask = new Shape();
         this.draw(this.hpMask,this.WIDTH);
         addChild(this.hpMask);
         this.hpMask.x = this.hpBM.x;
         this.hpMask.y = this.hpBM.y;
         this.hpBM.mask = this.hpMask;
         this.mpBGBM = new Bitmap();
         addChild(this.mpBGBM);
         this.mpBGBM.x = 94;
         this.mpBGBM.y = 414;
         this.mpBM = new Bitmap();
         this.mpBM.x = 95;
         this.mpBM.y = 415 + 10;
         addChild(this.mpBM);
         this.mpMask = new Shape();
         this.draw(this.mpMask,this.WIDTH);
         addChild(this.mpMask);
         this.mpMask.x = this.mpBM.x;
         this.mpMask.y = this.mpBM.y;
         this.mpBM.mask = this.mpMask;
         this.tf_hp = ComponentUtil.getTextField("",this,{
            "x":this.hpBGBM.x,
            "y":this.hpBGBM.y - 5 + 14,
            "realWidth":this.WIDTH,
            "realHeight":19
         });
         this.tf_mp = ComponentUtil.getTextField("",this,{
            "x":this.mpBGBM.x,
            "y":this.mpBGBM.y - 5 + 10,
            "realWidth":this.WIDTH,
            "realHeight":19
         });
         this.tf_hp.align = TextFormatAlign.CENTER;
         this.tf_mp.align = TextFormatAlign.CENTER;
         txtHP = ComponentUtil.getTextField(Data_lib.attribute[3][0],this,{
            "x":50,
            "y":384 + 14,
            "color":11904647,
            "size":12,
            "leading":0
         });
         txtMP = ComponentUtil.getTextField(Data_lib.attribute[5][0],this,{
            "x":50,
            "y":409 + 10,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.tf_name = ComponentUtil.getTextField("",this,{
            "x":88,
            "y":79,
            "realWidth":162,
            "align":TextAlign.CENTER,
            "size":16
         });
         this.tf_name.htmlText = Enum_job.getJobColorStr(GameUnitManager.hero.name,GameUnitManager.hero.job);
         this.vec_attribute = new Vector.<int>();
         this.vec_attribute.push(23,25,24,28,21,14,0,1,2,7,8,9,11,0,13,10);
         this.vec_str_attribute = new Vector.<String>();
         this.vec_str_attribute.push("level","job","party","strength","prestige","vigor",null,"minAtt","def","attRate","dod","crit","repelv",null,"attSpeed","critv");
         txtY = [116,116 + 20,134 + 20,154 + 20,174 + 20,194 + 20,0,260,260 + 20,289 + 20,311 + 20,333 + 20,355 + 20,0,405,405 + 20];
         this.vec_tf = new Vector.<MyTextField>(LEN_ATTRIBUTE,true);
         i = 0;
         while(i < LEN_ATTRIBUTE)
         {
            if(this.vec_str_attribute[i] != null)
            {
               txtY[i] = 115 + i * 20;
               tf = ComponentUtil.getTextField("",this,{
                  "x":320,
                  "y":txtY[i],
                  "color":11904647,
                  "size":12,
                  "leading":0
               });
               tf.mouseEnabled = true;
               tf.selectable = false;
               this.vec_tf[i] = tf;
               TipManager.bind(tf,Data_lib.attribute[this.vec_attribute[i]][Enum_lib_attribute.STR_DESCRIBE]);
            }
            i++;
         }
         this.vec_grids = new Vector.<View_Grid>(LEN_GRID,true);
         i = 0;
         while(i < LEN_GRID)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.ROLE_EQUIP;
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.isAutoLoad = false;
            grid.set_tf_info(HtmlUtil.font(Enum_role_equip.TXT[i],"#d5d57e"));
            grid.index = i + 1;
            grid.x = ARR_POS[i][0];
            grid.y = ARR_POS[i][1];
            addChild(grid);
            this.vec_grids[i] = grid;
            this.vec_grids[i].addEventListener(MouseEvent.MOUSE_UP,this.MOUSE_UP);
            this.vec_grids[i].addEventListener(MouseEvent.DOUBLE_CLICK,this.DOUBLE_CLICK);
            this.vec_grids[i].doubleClickEnabled = true;
            this.vec_grids[i].addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
            this.effVec.push(new Effect());
            i++;
         }
         this.hlSP = new ringSP();
         ComponentUtil.setPropertie(this.hlSP,{
            "x":200,
            "y":100
         });
         addChild(this.hlSP);
         setChildIndex(this.containers_move,numChildren - 1);
         this.baoshiZY = new BaoSZYTip();
         addChild(this.baoshiZY);
         this.baoshiZY.x = 85 + 192;
         this.baoshiZY.y = 106 + 302;
         this.jobExtraAtbSp = new View_ZhuanZhiAtbSp();
         ComponentUtil.setPropertie(this.jobExtraAtbSp,{
            "x":93,
            "y":92
         });
         addChild(this.jobExtraAtbSp);
      }
      
      public function updateJobIdx(v:uint) : void
      {
         this.jobExtraAtbSp.setJob(v);
      }
      
      private function bagUd() : void
      {
         var n:int = CommandManager.get_bag_count(44477);
         if(n == 0)
         {
            EffecObj.removeEffect(this.baoshiZY);
         }
         else
         {
            EffecObj.getEffec(this.baoshiZY);
         }
      }
      
      public function updateRing(ringID:int, qmd:int) : void
      {
         this.hlSP.visible = ringID > 0;
         if(ringID <= 0)
         {
            return;
         }
         var vo:VO_MarriageAttribute = new VO_MarriageAttribute();
         vo.ringId = ringID;
         vo.qmd = qmd;
         this.hlSP.setInfo(vo);
      }
      
      public function get equipV() : Vector.<View_Grid>
      {
         var __viewGrid:Vector.<View_Grid> = null;
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            __viewGrid = pan.equipV;
         });
         return __viewGrid;
      }
      
      private function mDownHandle(e:MouseEvent) : void
      {
         var temVo:Vo_valuable = e.target.vo as Vo_valuable;
         if(e.ctrlKey)
         {
            View_ChatPanel.show("【" + temVo.str_name + "】",temVo);
            return;
         }
         UIManager.startDrag(e);
      }
      
      private function playImg(iconUrl:String) : void
      {
         MassLoader.add(iconUrl,this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function onComplete(_inf:Object) : void
      {
         var c:Class = null;
         var c1:Class = null;
         var d:BitmapData = null;
         var d1:BitmapData = null;
         this._info = _inf;
         this._info.content.init();
         INTERVALFRAM = this._info.content.way;
         this.imgList = new Vector.<BitmapData>(INTERVALFRAM * this._info.content.actionFrame,true);
         this.imgListZM = new Vector.<BitmapData>(INTERVALFRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         var j1:int = 0;
         while(i < INTERVALFRAM * this._info.content.actionFrame)
         {
            if(i % INTERVALFRAM == 0)
            {
               c = this._info.applicationDomain.getDefinition("_" + (3 * this._info.content.actionFrame + j++)) as Class;
               c1 = this._info.applicationDomain.getDefinition("_" + (4 * this._info.content.actionFrame + j1++)) as Class;
               d = new c();
               d1 = new c1();
               this.imgList[i] = d;
               this.imgListZM[i] = d1;
            }
            i++;
         }
         this.playWeapon = GameUnitManager.hero.weapon;
         this.initWeapon(this.playWeapon);
      }
      
      private function initWeapon(weaponId:int) : void
      {
         var strId:String = "modelRes/role/weapon" + GameUnitManager.hero.sex + "/stand/" + weaponId + ".swf";
         MassLoader.add(strId,this.onComplete2,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function onComplete3(_inf:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         this._info3 = _inf;
         this._info3.content.init();
         INTERVALFRAM3 = this._info3.content.way;
         this.imgList3 = new Vector.<BitmapData>(INTERVALFRAM3 * this._info3.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < INTERVALFRAM3 * this._info3.content.actionFrame)
         {
            if(i % INTERVALFRAM2 == 0)
            {
               c = this._info3.applicationDomain.getDefinition("_" + (3 * this._info3.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList3[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.play);
      }
      
      private function initHorse(horseId:int) : void
      {
         var strId:String = "modelRes/role/horse/stand/" + horseId + ".swf";
         MassLoader.add(strId,this.onComplete3,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function onComplete2(_inf:Object) : void
      {
         var c:Class = null;
         var c1:Class = null;
         var d:BitmapData = null;
         var d1:BitmapData = null;
         this._info2 = _inf;
         this._info2.content.init();
         INTERVALFRAM2 = this._info2.content.way;
         this.imgList2 = new Vector.<BitmapData>(INTERVALFRAM2 * this._info2.content.actionFrame,true);
         this.imgList2ZM = new Vector.<BitmapData>(INTERVALFRAM2 * this._info2.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         var j1:int = 0;
         while(i < INTERVALFRAM2 * this._info2.content.actionFrame)
         {
            if(i % INTERVALFRAM2 == 0)
            {
               c = this._info2.applicationDomain.getDefinition("_" + (3 * this._info2.content.actionFrame + j++)) as Class;
               c1 = this._info2.applicationDomain.getDefinition("_" + (4 * this._info2.content.actionFrame + j1++)) as Class;
               d = new c();
               d1 = new c1();
               this.imgList2[i] = d;
               this.imgList2ZM[i] = d1;
            }
            i++;
         }
         this.playhorse = GameUnitManager.hero.horse;
         if(Boolean(this.playhorse))
         {
            this.initHorse(this.playhorse);
         }
         else
         {
            GameScene.instance.addFrameCallBack(this.play);
         }
      }
      
      public function play(interenal:int) : void
      {
         var FrameNum:int = 0;
         var bImgVec:Vector.<BitmapData> = null;
         var wImgVec:Vector.<BitmapData> = null;
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.play);
         }
         if(this.playBody != GameUnitManager.hero.body || this.playhorse != GameUnitManager.hero.horse || this.playWeapon != GameUnitManager.hero.weapon)
         {
            GameScene.instance.removeFrameCallBack(this.play);
            this.playBody = GameUnitManager.hero.body;
            this.playhorse = GameUnitManager.hero.horse;
            if(Boolean(this.playhorse))
            {
               this.playImg("modelRes/role/body/hstand/" + this.playBody + ".swf");
            }
            else
            {
               this.playImg("modelRes/role/body/stand/" + this.playBody + ".swf");
            }
         }
         if(Boolean(this.playhorse))
         {
            FrameNum = 3;
            bImgVec = this.imgList;
            wImgVec = this.imgList2;
         }
         else
         {
            FrameNum = 4;
            bImgVec = this.imgListZM;
            wImgVec = this.imgList2ZM;
         }
         if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 3)
         {
            this.containers_move.setChildIndex(this.bmpWeapon,this.containers_move.numChildren - 1);
         }
         else
         {
            this.containers_move.setChildIndex(this.bmpbody,this.containers_move.numChildren - 1);
         }
         if(this.playIndexBody < bImgVec.length)
         {
            if(bImgVec[this.playIndexBody] != null)
            {
               this.bmpbody.x = this._info.content.rect[this._info.content.actionFrame * FrameNum + this.playIndexBody / INTERVALFRAM][0];
               this.bmpbody.y = this._info.content.rect[this._info.content.actionFrame * FrameNum + this.playIndexBody / INTERVALFRAM][1];
               this.bmpbody.bitmapData = bImgVec[this.playIndexBody];
            }
            ++this.playIndexBody;
         }
         else
         {
            this.playIndexBody = 0;
         }
         if(!this.playhorse)
         {
            if(Boolean(this.bmpHorse))
            {
               this.bmpHorse.bitmapData = null;
            }
            this.containers_move.x = 191 - 23;
            this.containers_move.y = 298 + 33;
            this.containers_move.scaleX = 1;
            if(Boolean(this.eff1))
            {
               this.eff1.py = 0;
            }
            if(Boolean(this.eff1))
            {
               this.eff1.px = 0;
            }
            if(Boolean(this.eff1))
            {
               this.containers_move.setChildIndex(this.eff1,this.containers_move.numChildren - 1);
            }
            if(this.playIndexWeapon < wImgVec.length)
            {
               if(wImgVec[this.playIndexWeapon] != null)
               {
                  this.bmpWeapon.x = this._info2.content.rect[this._info2.content.actionFrame * FrameNum + this.playIndexWeapon / INTERVALFRAM2][0];
                  this.bmpWeapon.y = this._info2.content.rect[this._info2.content.actionFrame * FrameNum + this.playIndexWeapon / INTERVALFRAM2][1];
                  this.bmpWeapon.bitmapData = wImgVec[this.playIndexWeapon];
               }
               ++this.playIndexWeapon;
            }
            else
            {
               this.playIndexWeapon = 0;
            }
         }
         else
         {
            if(Boolean(this.bmpWeapon))
            {
               this.bmpWeapon.bitmapData = null;
            }
            this.containers_move.x = 191;
            this.containers_move.y = 298;
            this.containers_move.scaleX = -1;
            if(Boolean(this.eff1))
            {
               this.eff1.px = 11;
            }
            if(Boolean(this.eff1))
            {
               this.eff1.py = -18;
            }
            if(Boolean(this.imgList3))
            {
               if(this.playIndexHorse < this.imgList3.length)
               {
                  if(this.imgList3[this.playIndexHorse] != null)
                  {
                     this.bmpHorse.x = this._info3.content.rect[this._info3.content.actionFrame * 3 + this.playIndexHorse / INTERVALFRAM3][0];
                     this.bmpHorse.y = this._info3.content.rect[this._info3.content.actionFrame * 3 + this.playIndexHorse / INTERVALFRAM3][1];
                     this.bmpHorse.bitmapData = this.imgList3[this.playIndexHorse];
                  }
                  ++this.playIndexHorse;
               }
               else
               {
                  this.playIndexHorse = 0;
               }
            }
         }
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      public function strengthenSet(levelTen:int, levelSix:int, levelSixNums:int, level:int, nums:int) : void
      {
         this._levelTen = levelTen;
         this._levelSix = levelSix;
         this._levelSixNums = levelSixNums;
         this._level = level;
         this._nums = nums;
         if(this.visible)
         {
            this.addEff();
         }
      }
      
      public function getData(type:int, level:int) : Array
      {
         var key:* = undefined;
         var data:Dictionary = Data_lib.equipStrongAddAward;
         for(key in data)
         {
            if(data[key][0] == type && data[key][1] == level)
            {
               return data[key];
            }
         }
         return [];
      }
      
      public function get_items_data() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temArr = pan.get_items_data();
         });
         return temArr;
      }
      
      public function get_items_dataC() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temArr = pan.get_items_dataC();
         });
         return temArr;
      }
      
      public function get_can_jinji_equip() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temArr = pan.get_can_jinji_equip();
         });
         return temArr;
      }
      
      public function get_equips_noFasion() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temArr = pan.get_equips_noFasion();
         });
         return temArr;
      }
      
      public function get_can_dianHua() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temArr = pan.get_can_dianHuaEquip();
         });
         return temArr;
      }
      
      public function getCZ_data() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temArr = pan.getCZ_data();
         });
         return temArr;
      }
      
      public function getC_data() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temArr = pan.getC_data();
         });
         return temArr;
      }
      
      public function getXLEquip_skillId() : int
      {
         return 0;
      }
      
      public function getVoIndex() : int
      {
         var i:int = 0;
         while(i < LEN_GRID)
         {
            if(Boolean(this.vec_grids[i].vo))
            {
               return i;
            }
            i++;
         }
         return LEN_GRID - 1;
      }
      
      public function getSmallestGrid() : View_Grid
      {
         var temGrid:View_Grid = null;
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temGrid = pan.getSmallestGrid();
         });
         return temGrid;
      }
      
      public function getZuoQi() : Vector.<Vo_valuable>
      {
         var temVec:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            temVec = pan.getZuoQi();
         });
         return temVec;
      }
      
      public function get_item_index(_index:int) : Vo_valuable
      {
         var __vo:Vo_valuable = null;
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            __vo = pan.get_item_index(_index);
         });
         return __vo;
      }
      
      public function getEuqipSingle(enum_pos:int) : Vo_equip
      {
         var __vo:Vo_equip = null;
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            __vo = pan.getEuqipSingle(enum_pos);
         });
         return __vo;
      }
      
      protected function onRollOver(event:MouseEvent) : void
      {
         GameScene.upUILayer.addChild(UIManager.rolePanel.tip);
         this.sp.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.sp.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         this.sp.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         GameScene.upUILayer.removeChild(UIManager.rolePanel.tip);
      }
      
      private function onMouseMove(e:MouseEvent) : void
      {
         var data1:Array = null;
         var data2:Array = null;
         var str1:String = null;
         var str2:String = null;
         var color:String = null;
         var strVec:Vector.<String> = new Vector.<String>();
         if(this._levelTen == 0 && this._levelSix == 0)
         {
            data1 = this.getData(6,this._level);
            data2 = this.getData(10,this._level);
            strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,this._level) + "</font><font color=\'#7CCCF2\' size=\'12\'>(" + this._nums + "/10)</font>\n" + "<font color=\'#999999\' size=\'12\'>6 " + LangConfig.getWord("10011",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#999999\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data2[V1] + "   " + Data_lib.attribute[1][0] + "+" + data2[V2] + "   " + Data_lib.attribute[2][0] + "+" + data2[V3] + "</font>\n" + "<font color=\'#999999\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data2[V4] + "%</font>");
         }
         else if(this._levelTen == 10)
         {
            data1 = this.getData(10,10);
            strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,10) + "(10/10)</font><font color=\'#7CCCF2\' size=\'12\'>   " + LangConfig.getWord("10014",1) + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data1[V4] + "%</font>");
         }
         else
         {
            str1 = "";
            if(Boolean(this._levelTen))
            {
               data1 = this.getData(10,this._levelTen);
               str1 = "<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,this._levelTen) + "</font><font color=\'#7CCCF2\' size=\'12\'>   " + LangConfig.getWord("10014",1) + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data1[V4] + "%</font>";
            }
            str2 = "";
            color = "";
            if(Boolean(this._levelSix))
            {
               color = "9ADA78";
               data1 = this.getData(6,this._levelSix);
               data2 = this.getData(10,this._levelSix);
            }
            else
            {
               color = "999999";
               data1 = this.getData(6,this._levelTen + 2);
               data2 = this.getData(10,this._levelTen + 2);
            }
            str2 = "<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,Boolean(this._levelSix) ? this._levelSix : this._levelTen + 2) + "</font><font color=\'#7CCCF2\' size=\'12\'>   (" + this._levelSixNums + "/10)</font>\n" + "<font color=\'#" + color + "\'>6 " + LangConfig.getWord("10011",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#999999\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data2[V1] + "   " + Data_lib.attribute[1][0] + "+" + data2[V2] + "   " + Data_lib.attribute[2][0] + "+" + data2[V3] + "</font>\n" + "<font color=\'#999999\'>　　　" + LangConfig.getWord("10013",1) + "+" + data2[V4] + "%</font>";
            if(Boolean(str2))
            {
               strVec.push(str2);
            }
            if(Boolean(str1))
            {
               strVec.push(str1);
            }
         }
         UIManager.rolePanel.tip.updata(this,strVec);
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
      
      public function update_equip() : void
      {
         this.tf_name.text = Model_heFu.repNameByHero(GameUnitManager.hero.name);
         this.vec_Vo_equip_cache = CommandManager.get_role_vec_equip();
         var i:int = 0;
         while(i < LEN_GRID)
         {
            this.vec_grids[i].vo = this.vec_Vo_equip_cache[i];
            i++;
         }
         if(visible)
         {
            this.showGridEff();
            this.showMerryG();
         }
      }
      
      private function showMerryG() : void
      {
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this.vec_grids.length)
         {
            this.vec_grids[i].isAutoLoad = true;
            this.vec_grids[i].beginLoad();
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var ss:String = null;
         super.visible = value;
         if(value)
         {
            this.hlSP.isAutoLoad = true;
            this.jobExtraAtbSp.enableLoad();
            Utils.getLoadBitmap("resource/image/icon/23" + Enum_job.getBaseJob(GameUnitManager.hero.job) + 5 + GameUnitManager.hero.sex + ".jpg",this.bmp_head);
            this.addEff();
            this.lvlUp();
            this.bagUd();
            this.update_attribute();
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.lvlUp);
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.bagUd);
            if(!this.hpBGBM.bitmapData)
            {
               Utils.loadTitle("lang/ch/Role_Imgs.swf","ProgressBG",this.hpBGBM,{
                  "x":94,
                  "y":389 + 14
               },null,this.onLoadCom);
            }
            if(!this.hpBM.bitmapData)
            {
               Utils.loadTitle("lang/ch/Role_Imgs.swf","Player_HP",this.hpBM,{
                  "x":95,
                  "y":390 + 14
               },null);
            }
            if(!this.mpBGBM.bitmapData)
            {
               Utils.loadTitle("lang/ch/Role_Imgs.swf","ProgressBG",this.mpBGBM,{
                  "x":94,
                  "y":414 + 10
               },null);
            }
            if(!this.mpBM.bitmapData)
            {
               Utils.loadTitle("lang/ch/Role_Imgs.swf","Player_MP",this.mpBM,{
                  "x":95,
                  "y":415 + 10
               },null);
            }
            this.playBody = GameUnitManager.hero.body;
            this.playhorse = GameUnitManager.hero.horse;
            if(Boolean(this.playhorse))
            {
               ss = "modelRes/role/body/hstand/" + this.playBody + ".swf";
            }
            else
            {
               ss = "modelRes/role/body/stand/" + this.playBody + ".swf";
            }
            this.playImg(ss);
            if(!this.effIcon.bitmapData)
            {
               Utils.loadTitle("lang/ch/Role_Imgs.swf","TaoZhuang",this.effIcon);
            }
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
            }
            this.showGridEff();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.lvlUp);
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.bagUd);
            if(!this.isFirstOpen)
            {
               this.removeGridEff();
            }
            this.removeEff();
         }
      }
      
      private function onLoadCom() : void
      {
         this.btnChengHao = ComponentUtil.getButton("","Button_OrangeUp",this,{
            "x":415,
            "y":79,
            "textColor":16184781
         });
         this.btnChengHao.addEventListener(MouseEvent.CLICK,this.chengHaoHandler);
         this.TipChengHaoSpr = new Sprite();
         this.TipChengHaoSpr.graphics.beginFill(0,0);
         this.TipChengHaoSpr.graphics.drawRect(0,0,this.btnChengHao.width,this.btnChengHao.height);
         this.TipChengHaoSpr.x = this.btnChengHao.x;
         this.TipChengHaoSpr.y = this.btnChengHao.y;
         addChild(this.TipChengHaoSpr);
         this.update_attribute();
      }
      
      private function showGridEff() : void
      {
         if(Model_init.isChangeEff)
         {
            return;
         }
         this.removeGridEff();
         var i:int = 0;
         while(i < this.vec_grids.length)
         {
            if(Boolean(this.vec_grids[i].vo))
            {
               if((this.vec_grids[i].vo as Vo_equip).color == 5 && (this.vec_grids[i].vo as Vo_equip).lv == 10)
               {
                  this.effVec[i] = EffectManager.addEffect("35064",this.vec_grids[i],1000,14.5,16,true);
               }
            }
            i++;
         }
      }
      
      private function lvlUp() : void
      {
         this.baoshiZY.show(Vo_baoshiZY.StoneLvl);
      }
      
      private function removeGridEff() : void
      {
         if(Model_init.isChangeEff)
         {
            return;
         }
         if(!this.effVec.length || !this.vec_grids || !this.vec_grids.length)
         {
            return;
         }
         var i:int = 0;
         while(i < this.vec_grids.length)
         {
            if(Boolean(this.effVec[i]))
            {
               EffectManager.removeEffect(this.effVec[i]);
               this.effVec[i] = null;
            }
            i++;
         }
      }
      
      private function addEff() : void
      {
         var type:int = 0;
         var d:Array = this.getData(10,this._levelTen);
         if(Boolean(d.length))
         {
            type = int(d[EFF]);
         }
         this.removeEff();
         if(Boolean(type))
         {
            if(!this.eff1)
            {
               this.eff1 = EffectManager.addEffect(this.vecEffId[type - 1],this.containers_move,1000,0,0,true);
            }
            if(!this.eff2)
            {
               this.eff2 = EffectManager.addEffect("35041",this.effLevel,1000,264 - 17,425,true);
            }
            if(type == 1)
            {
               this.eff2.transform.colorTransform = Util.qhtz1;
            }
            else if(type == 2)
            {
               this.eff2.transform.colorTransform = Util.qhtz2;
            }
            else if(type == 3)
            {
               this.eff2.transform.colorTransform = Util.qhtz3;
            }
         }
      }
      
      private function removeEff() : void
      {
         if(Boolean(this.eff1))
         {
            EffectManager.removeEffect(this.eff1);
            this.eff1 = null;
         }
         if(Boolean(this.eff2))
         {
            EffectManager.removeEffect(this.eff2);
            this.eff2 = null;
         }
      }
      
      public function updataStoneLvl(stoneLvl:int) : void
      {
         this.baoshiZY.show(stoneLvl);
      }
      
      public function update_attribute() : void
      {
         var w:int = 0;
         var temStr:String = null;
         var _obj:DisplayObject = null;
         var nextColor:String = null;
         var __obj:DisplayObject = null;
         this.updateJobIdx(GameUnitManager.hero.job);
         var i:int = 0;
         while(i < LEN_ATTRIBUTE)
         {
            if(this.vec_tf[i] != null)
            {
               if(i == 1)
               {
                  this.vec_tf[i].htmlText = Data_lib.attribute[this.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(Enum_job.getMenPai(GameUnitManager.hero[this.vec_str_attribute[i]],false),ColorConstant.ROLE_ATTR_COLOR);
               }
               else if(i != 2)
               {
                  this.vec_tf[i].htmlText = Data_lib.attribute[this.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(GameUnitManager.hero[this.vec_str_attribute[i]],ColorConstant.ROLE_ATTR_COLOR);
               }
               else
               {
                  trace(GameUnitManager.hero[this.vec_str_attribute[i]]);
                  temStr = GameUnitManager.hero[this.vec_str_attribute[i]];
                  if(temStr == "")
                  {
                     temStr = LangConfig.getWord("10015",1);
                  }
                  this.vec_tf[i].htmlText = Data_lib.attribute[this.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(temStr,ColorConstant.ROLE_ATTR_COLOR);
               }
            }
            i++;
         }
         w = this.WIDTH * GameUnitManager.hero.hp / GameUnitManager.hero.hpMax;
         this.hpMask.width = w;
         w = this.WIDTH * GameUnitManager.hero.mp / GameUnitManager.hero.mpMax;
         this.mpMask.width = w;
         this.tf_hp.text = String(GameUnitManager.hero.hp) + "/" + String(GameUnitManager.hero.hpMax);
         this.tf_mp.text = String(GameUnitManager.hero.mp) + "/" + String(GameUnitManager.hero.mpMax);
         var arrCurCH:Array = Data_lib.chengHao[GameUnitManager.hero.chengHao];
         var chengHao:int = GameUnitManager.hero.chengHao;
         if(chengHao == 0)
         {
            return;
         }
         var curColor:String = ColorConstant.getColorStr(vecColor[Data_lib.chengHao[GameUnitManager.hero.chengHao][COLOR] - 1]);
         this.arrNextCH = Data_lib.chengHao[GameUnitManager.hero.chengHao + 1];
         this.txtChengHao.htmlText = LangConfig.getWord("10094",1) + "<font color=\'" + "0x11904647" + "\'>" + arrCurCH[TITLE] + "</font>";
         if(Boolean(this.arrNextCH))
         {
            if(!this.btnChengHao)
            {
               return;
            }
            this.btnChengHao.enabled = GameUnitManager.hero.yeLi >= this.arrNextCH[YELI];
            this.hasEvent(this.btnChengHao.enabled);
            if(this.btnChengHao.enabled)
            {
               _obj = this.btnChengHao;
               this.TipChengHaoSpr.visible = false;
            }
            else
            {
               this.TipChengHaoSpr.visible = true;
               _obj = this.TipChengHaoSpr;
            }
            nextColor = ColorConstant.getColorStr(vecColor[Data_lib.chengHao[GameUnitManager.hero.chengHao + 1][COLOR] - 1]);
            TipManager.bind(_obj,"<font color=\'#ffac00\'>" + LangConfig.getWord("10095",1) + "<font color=\'" + nextColor + "\'>" + this.arrNextCH[YELI] + LangConfig.getWord("10096",1) + "</font>" + LangConfig.getWord("10097",1) + "<font color=\'" + nextColor + "\'>" + this.arrNextCH[TITLE] + "</font><br>" + LangConfig.getWord("10098",1) + "<font color=\'" + curColor + "\'>" + LangConfig.getWord("10099",1) + arrCurCH[DATA].split("_")[1] + "</font><br>" + LangConfig.getWord("10100",1) + "<font color=\'" + nextColor + "\'>" + LangConfig.getWord("10099",1) + this.arrNextCH[DATA].split("_")[1] + "</font><br>" + "<font color=\'#049a47\'>" + LangConfig.getWord("10101",1) + GameUnitManager.hero.yeLi + "</font></font>" + LangConfig.getWord("10655",1));
         }
         else
         {
            if(!this.btnChengHao)
            {
               return;
            }
            if(Boolean(this.arrNextCH))
            {
               this.btnChengHao.enabled = GameUnitManager.hero.yeLi >= this.arrNextCH[YELI];
            }
            this.hasEvent(this.btnChengHao.enabled);
            if(this.btnChengHao.enabled)
            {
               __obj = this.btnChengHao;
               this.TipChengHaoSpr.visible = false;
            }
            else
            {
               this.TipChengHaoSpr.visible = true;
               __obj = this.TipChengHaoSpr;
            }
            TipManager.bind(__obj,"<font color=\'#ffac00\'>" + LangConfig.getWord("10593",1) + "<font color=\'" + curColor + "\'>" + arrCurCH[TITLE] + "</font><br>" + LangConfig.getWord("10098",1) + "<font color=\'" + curColor + "\'>" + LangConfig.getWord("10099",1) + arrCurCH[DATA].split("_")[1] + "</font><br>" + "<font color=\'#049a47\'>" + LangConfig.getWord("10101",1) + GameUnitManager.hero.yeLi + "</font></font>" + LangConfig.getWord("10655",1));
         }
      }
      
      private function hasEvent(value:Boolean) : void
      {
         if(value)
         {
            this.btnChengHao.addEventListener(MouseEvent.CLICK,this.chengHaoHandler);
         }
         else
         {
            this.btnChengHao.removeEventListener(MouseEvent.CLICK,this.chengHaoHandler);
         }
      }
      
      private function chengHaoHandler(e:MouseEvent) : void
      {
         if(Boolean(this.arrNextCH) && Boolean(this.arrNextCH.length))
         {
            if(GameUnitManager.hero.yeLi >= this.arrNextCH[YELI])
            {
               HumanCGMessage.CG_CHENGHAO_UPGRADE();
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10102",1));
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10103",1));
         }
      }
      
      private function MOUSE_UP(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var vo_equip:Vo_equip = null;
         var upGrid:View_Grid = e.target as View_Grid;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            vo_equip = dragGrid.vo as Vo_equip;
            if(Boolean(vo_equip) && dragGrid.type == Enum_type_grid.BAG)
            {
               if(GameUnitManager.hero.level < vo_equip.lv_use)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("10016",1));
               }
               else if(Enum_job.getBaseJob(GameUnitManager.hero.job) != vo_equip.job && vo_equip.job != Enum_job.ALL)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("10017",1));
               }
               else
               {
                  RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.BAG_ROLE,dragGrid.vo.gridId,upGrid.index);
               }
            }
         }
      }
      
      private function DOUBLE_CLICK(e:MouseEvent) : void
      {
         var upGrid:View_Grid = e.target as View_Grid;
         if(Boolean(upGrid.vo))
         {
            if(CommandManager.get_bag_canUse() - CommandManager.get_bag_used() == 0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10018",1));
               return;
            }
            RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.ROLE_BAG,upGrid.vo.gridId);
         }
      }
   }
}

import com.yiTian.manager.TipManager;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.marriage.MarriageGetWord;
import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

class ringSP extends Sprite
{
   
   private var bm_icon:Bitmap;
   
   private var qinmiLv:int;
   
   private var _vo:VO_MarriageAttribute;
   
   private var bm_url:String = "";
   
   private var _isAutoLoad:Boolean = false;
   
   public function ringSP()
   {
      super();
      this.bm_icon = new Bitmap();
      addChild(this.bm_icon);
   }
   
   public function setInfo(vo:VO_MarriageAttribute) : void
   {
      var rId:int = vo.ringId;
      var qmd:int = vo.qmd;
      this._vo = vo;
      var lv:int = rId - 46440;
      this.qinmiLv = MarriageGetWord.getQMDIndex(qmd);
      this._vo.qmdLv = this.qinmiLv;
      addEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
      addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      var effLv:int = this.qinmiLv / 2;
      var effArr:Array = [16777215,65280,54783,16711935,16744192];
      if(effArr[effLv] > 0)
      {
         filters = [new GlowFilter(effArr[effLv],0.8,25,25,2,1)];
      }
      this.bm_url = "resource/image/ringBM/lv" + lv.toString() + ".png";
      if(this._isAutoLoad)
      {
         Utils.getLoadBitmap(this.bm_url,this.bm_icon);
         this.bm_url = "";
      }
   }
   
   private function rollOverHd(evt:MouseEvent) : void
   {
      TipManager.update(this._vo);
   }
   
   private function rollOutHd(evt:MouseEvent) : void
   {
      TipManager.hide();
   }
   
   public function set isAutoLoad(b:Boolean) : void
   {
      if(!this._isAutoLoad && b && this.bm_url != "")
      {
         Utils.getLoadBitmap(this.bm_url,this.bm_icon);
         this.bm_url = "";
      }
      this._isAutoLoad = b;
   }
}
