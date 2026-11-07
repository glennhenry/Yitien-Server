package com.yiTian.view.modules.chargeGuide
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.SingleLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class Fashion_Item extends Sprite
   {
      
      private static var INTERVALFRAM:int;
      
      private static var INTERVALFRAM2:int;
      
      private static var isLoad:Boolean = false;
      
      private static var FirstOpen:Boolean = true;
      
      private var button:Button;
      
      private var vo:Vo_equip;
      
      private var _info2:Object;
      
      private var _info:Object;
      
      private var bmp:Bitmap;
      
      private var tf:MyTextField;
      
      private var spri:Sprite;
      
      private var _job:int;
      
      private var _idx:int;
      
      private var content1:MyTextField;
      
      private var content2:MyTextField;
      
      private var _vo:Vo_equip;
      
      private var titleTf:MyTextField;
      
      private var _wpId:int;
      
      private var idStr:String;
      
      private var bmpWeapon:Bitmap;
      
      private var imgList:Vector.<BitmapData>;
      
      private var imgList2:Vector.<BitmapData>;
      
      private var weaponId:int;
      
      private var _playIndex:int;
      
      private var _playIndex2:int;
      
      public function Fashion_Item()
      {
         super();
         this.spri = new Sprite();
         this.spri.graphics.beginFill(0,0);
         this.spri.graphics.drawRect(75,48,100,120);
         this.spri.graphics.endFill();
         addChild(this.spri);
         this.spri.x = 125;
         this.spri.y = 157;
         this.bmpWeapon = new Bitmap();
         this.spri.addChild(this.bmpWeapon);
         this.bmp = new Bitmap();
         this.spri.addChild(this.bmp);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":25,
            "y":221
         });
         this.content1 = ComponentUtil.getTextField("",this,{
            "x":25,
            "y":221
         });
         this.content1.multiline = true;
         this._vo = new Vo_equip();
         this.content2 = ComponentUtil.getTextField("",this,{
            "x":137,
            "y":221
         });
         this.content2.multiline = true;
         this.titleTf = ComponentUtil.getTextField("",this,{
            "x":56,
            "y":7,
            "color":16711935,
            "realWidth":140
         });
         this.titleTf.align = TextFormatAlign.CENTER;
         this.button = ComponentUtil.getButton(LangConfig.getWord("7",0),"Button_Orange05",this,{
            "x":83,
            "y":278
         });
         this.button.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function getVo(_sex:int) : int
      {
         var _id:int = 0;
         if(_sex == 1)
         {
            if(this._idx == 0)
            {
               _id = 99101;
            }
            else
            {
               _id = 99111;
            }
         }
         else if(_sex == 2)
         {
            if(this._idx == 1)
            {
               _id = 99112;
            }
            else
            {
               _id = 99102;
            }
         }
         return _id;
      }
      
      public function init(idStr:String, _job:int, _idx:int) : void
      {
         var lifePCT:String;
         var attackPCT:String;
         var defensePCT:String;
         var life:String;
         var attack:String;
         var defense:String;
         this._job = _job;
         this._idx = _idx;
         this.idStr = idStr;
         this._vo.id = this.getVo(GameUnitManager.hero.sex);
         this._wpId = this._vo.id;
         this._vo.Init_lib();
         this.titleTf.htmlText = HtmlUtil.font(this._vo.str_name,Model_shop.get_color_arr[this._vo.color]);
         lifePCT = HtmlUtil.font(LangConfig.getWord("60095",6),"#f1edca") + "+" + this._vo.vec_basic[1] + "%";
         attackPCT = HtmlUtil.font(LangConfig.getWord("60096",6),"#f1edca") + "+" + this._vo.vec_basic[4] + "%";
         defensePCT = HtmlUtil.font(LangConfig.getWord("60097",6),"#f1edca") + "+" + this._vo.vec_basic[7] + "%";
         life = HtmlUtil.font(LangConfig.getWord("60095",6),"#f1edca") + "+" + this._vo.vec_basic[10];
         attack = HtmlUtil.font(LangConfig.getWord("60096",6),"#f1edca") + "+" + this._vo.vec_basic[13];
         defense = HtmlUtil.font(LangConfig.getWord("60097",6),"#f1edca") + "+" + this._vo.vec_basic[16];
         this.content1.htmlText = "<font color=\'#ffff00\'>" + lifePCT + "<br>" + attackPCT + "<br>" + defensePCT + "<br>" + "</font>";
         this.content2.htmlText = "<font color=\'#ffff00\'>" + life + "<br>" + attack + "<br>" + defense + "</font>";
         this.visible = true;
         if(Enum_job.getBaseJob(_job) == 3 && GameUnitManager.hero.sex == 1 || Enum_job.getBaseJob(_job) == 4 && GameUnitManager.hero.sex == 1)
         {
            this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
         }
         else
         {
            this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
         }
         if(!Global.Guide_Cloth_Itemdm)
         {
            SingleLoader.add("lang/ch/Guide_Cloth_Item5.swf",function(info:Object):void
            {
               Global.Guide_Cloth_Itemdm = info.applicationDomain;
               loadBmp();
            });
         }
         else if(!isLoad)
         {
            this.loadBmp();
         }
      }
      
      private function loadBmp() : void
      {
         isLoad = true;
         var b:Bitmap = ComponentUtil.getBitmap("Guide_Cloth_Item",this,{
            "x":0,
            "y":0
         },Global.Guide_Cloth_Itemdm);
         setChildIndex(b,0);
      }
      
      private function initWeapon(_id:int) : void
      {
         this.weaponId = _id;
         var strId:String = "modelRes/role/weapon" + GameUnitManager.hero.sex + "/stand/" + _id + ".swf";
         MassLoader.add(strId,this.onComplete2,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function playImg(iconUrl:String) : void
      {
         MassLoader.add(iconUrl,this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function onComplete(_inf:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         this._info = _inf;
         this._info.content.init();
         INTERVALFRAM = this._info.content.way;
         this.imgList = new Vector.<BitmapData>(INTERVALFRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < INTERVALFRAM * this._info.content.actionFrame)
         {
            if(i % INTERVALFRAM == 0)
            {
               c = this._info.applicationDomain.getDefinition("_" + (4 * this._info.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList[i] = d;
            }
            i++;
         }
         this.initWeapon(GameUnitManager.hero.weapon);
      }
      
      private function onComplete2(_inf:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         this._info2 = _inf;
         this._info2.content.init();
         INTERVALFRAM2 = this._info2.content.way;
         this.imgList2 = new Vector.<BitmapData>(INTERVALFRAM2 * this._info2.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < INTERVALFRAM2 * this._info2.content.actionFrame)
         {
            if(i % INTERVALFRAM2 == 0)
            {
               c = this._info2.applicationDomain.getDefinition("_" + (4 * this._info2.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList2[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.play);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(FirstOpen || GameUnitManager.hero.weapon != this.weaponId)
            {
               this.playImg("modelRes/role/body/stand/" + this.idStr + ".swf");
            }
            else
            {
               GameScene.instance.addFrameCallBack(this.play);
            }
            FirstOpen = false;
         }
      }
      
      public function play(interenal:int) : void
      {
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.play);
         }
         if(GameUnitManager.hero.weapon != this.weaponId)
         {
            GameScene.instance.removeFrameCallBack(this.play);
            this.playImg("modelRes/role/body/stand/" + this.idStr + ".swf");
            return;
         }
         if(this._playIndex < this.imgList.length)
         {
            if(this.imgList[this._playIndex] != null)
            {
               this.bmp.x = this._info.content.rect[this._info.content.actionFrame * 4 + this._playIndex / INTERVALFRAM][0];
               this.bmp.y = this._info.content.rect[this._info.content.actionFrame * 4 + this._playIndex / INTERVALFRAM][1];
               trace("body",this.idStr,this.bmp.x,this.bmp.y);
               this.bmp.bitmapData = this.imgList[this._playIndex];
            }
            ++this._playIndex;
         }
         else
         {
            this._playIndex = 0;
         }
         if(this._playIndex2 < this.imgList2.length)
         {
            if(this.imgList2[this._playIndex2] != null)
            {
               this.bmpWeapon.x = this._info2.content.rect[this._info2.content.actionFrame * 4 + this._playIndex2 / INTERVALFRAM2][0];
               this.bmpWeapon.y = this._info2.content.rect[this._info2.content.actionFrame * 4 + this._playIndex2 / INTERVALFRAM2][1];
               trace("weapon",this.idStr,this.bmpWeapon.x,this.bmpWeapon.y);
               this.bmpWeapon.bitmapData = this.imgList2[this._playIndex2];
            }
            ++this._playIndex2;
         }
         else
         {
            this._playIndex2 = 0;
         }
      }
      
      private function onClick(event:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < 288)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60098",6));
            UIManager.yuanBaoXiang.visible = true;
            return;
         }
         UIManager.storeTip.visible = true;
         UIManager.storeTip.update(this._wpId,1,7,16000,288,9999,2,this._vo.str_name);
      }
   }
}

