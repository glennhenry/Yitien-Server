package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_Pet;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.petD.EffectPan;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class LianHuaPanel extends EffectPan
   {
      
      private static var _instance:LianHuaPanel;
      
      public static const idArr:Array = [46313,46314,46315,46316,46317];
      
      private const WIDTH:int = 218;
      
      private const HEIGHT:int = 10;
      
      private var lianHuaBM:Bitmap;
      
      private var lianHuaMask:Shape;
      
      private var chengZhangTxt:MyTextField;
      
      public var lianHuaBtn:Button;
      
      private var tuPoBtn:Button;
      
      private var txtCZLevel:MyTextField;
      
      private var itemVec:Vector.<PetListItem>;
      
      private var chengZhangBM:Bitmap;
      
      private var chengZhangSP:Sprite;
      
      private var _lianHuaVO:LianHuaVO;
      
      private var backDi:Bitmap = new Bitmap();
      
      private var numDi:MyTextField;
      
      private var openDi:Bitmap;
      
      private var DiTxt:Bitmap = new Bitmap();
      
      private var grid:View_Grid;
      
      private var diSpr:Sprite = new Sprite();
      
      private var _bgLayer:Sprite = new Sprite();
      
      private var backLianHua:ScaleBitmap;
      
      private var curItem:PetListItem;
      
      private var defaultItem:Vo_Pet;
      
      private var storeIdArr:Array = [];
      
      private var nameArr:Array = [LangConfig.getWord("10058",1),LangConfig.getWord("10059",1),LangConfig.getWord("10060",1),LangConfig.getWord("10061",1),LangConfig.getWord("10062",1)];
      
      private var data:Array;
      
      private var lianHuaBG:Bitmap;
      
      private var CZBMVec:Vector.<String> = new <String>["CZ_L0","CZ_L1","CZ_L2","CZ_L3","CZ_L4","CZ_L5","CZ_L6","CZ_L7","CZ_L8","CZ_L9","CZ_L10","CZ_L11","CZ_L12","CZ_L13"];
      
      private var eff:Effect;
      
      private var effSp:Sprite;
      
      public function LianHuaPanel()
      {
         var i:uint = 0;
         var item:PetListItem = null;
         super();
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":-2,
            "y":0,
            "width":245,
            "height":283
         },Global.Img_Cdm);
         this.backLianHua = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":8,
            "y":52,
            "width":220,
            "height":160
         },Global.Img_Cdm);
         addChild(this._bgLayer);
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Back_CZDi",this.backDi,{
            "x":0,
            "y":0
         },this._bgLayer);
         this.diSpr.x = 89;
         this.diSpr.y = 114;
         addChild(this.diSpr);
         this.diSpr.visible = false;
         this.backDi.visible = false;
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Text_Di",this.DiTxt,{
            "x":0,
            "y":0
         },this.diSpr);
         this.chengZhangBM = new Bitmap();
         this.chengZhangBM.x = 120;
         this.chengZhangBM.y = 9;
         addChild(this.chengZhangBM);
         this.chengZhangSP = new Sprite();
         this.chengZhangSP.graphics.beginFill(0,0);
         this.chengZhangSP.graphics.drawRect(0,0,20,20);
         this.chengZhangSP.graphics.endFill();
         addChild(this.chengZhangSP);
         this.chengZhangSP.x = this.chengZhangBM.x;
         this.chengZhangSP.y = this.chengZhangBM.y;
         this.txtCZLevel = ComponentUtil.getTextField(LangConfig.getWord("10054",1,10),this,{
            "x":10,
            "y":10,
            "color":11904647
         });
         this.txtCZLevel.mouseEnabled = true;
         TipManager.bind(this.txtCZLevel,"成长等级越高，宠物基础属性加成越高");
         this.lianHuaBG = new Bitmap();
         this.lianHuaBG.x = 8;
         this.lianHuaBG.y = 31;
         addChild(this.lianHuaBG);
         this.lianHuaBM = new Bitmap();
         this.lianHuaBM.x = 9;
         this.lianHuaBM.y = 32;
         addChild(this.lianHuaBM);
         this.lianHuaMask = new Shape();
         this.draw(this.lianHuaMask,this.WIDTH);
         addChild(this.lianHuaMask);
         this.lianHuaMask.x = this.lianHuaBM.x;
         this.lianHuaMask.y = this.lianHuaBM.y;
         this.lianHuaBM.mask = this.lianHuaMask;
         this.chengZhangTxt = ComponentUtil.getTextField("100/100",this,{
            "x":this.lianHuaBM.x,
            "y":this.lianHuaBM.y - 5
         });
         this.chengZhangTxt.realWidth = this.WIDTH;
         this.chengZhangTxt.align = TextFormatAlign.CENTER;
         this.lianHuaBtn = ComponentUtil.getButton(LangConfig.getWord("10055",1),"Button_Orange",this,{
            "x":82,
            "y":235,
            "textColor":16184781
         },Global.Img_Cdm);
         this.lianHuaBtn.textColor = 16383744;
         this.lianHuaBtn.textOverColor = 16383744;
         this.lianHuaBtn.addEventListener(MouseEvent.CLICK,this.lianHuaHandler);
         this.tuPoBtn = ComponentUtil.getButton("突破","Button_Orange",this,{
            "x":82,
            "y":247,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tuPoBtn.textColor = 16383744;
         this.tuPoBtn.textOverColor = 16383744;
         this.tuPoBtn.addEventListener(MouseEvent.CLICK,this.tupoHandler);
         this.openDi = ComponentUtil.getBitmap("Grid_Open",this,{
            "x":135,
            "y":202
         },Global.Img_Cdm);
         TipManager.bind(this.diSpr,"1、突破帝阶后成长上限提升，可继续提升成长等级。\n2、突破帝阶后，开启技能槽刷新顶级技能。");
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_tf_count(true,true,true);
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         addChild(this.grid);
         this.grid.x = 135 + 2;
         this.grid.y = 202 + 2;
         var vo:Vo_item = new Vo_item();
         vo.id = 44751;
         vo.Init_lib();
         this.grid.vo = vo;
         this.numDi = ComponentUtil.getTextField("X 10",this,{
            "x":178,
            "y":220,
            "color":12582911,
            "size":12,
            "leading":0
         });
         this.itemVec = new Vector.<PetListItem>();
         i = 0;
         while(i < 3)
         {
            item = new PetListItem(PetPanel.LIANHUA);
            addChild(item);
            item.x = 17.3;
            item.y = 62 + (40 + 5) * i;
            item.addEventListener(MouseEvent.CLICK,this.itemOnClick);
            this.itemVec.push(item);
            i++;
         }
         this.itemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public static function get instance() : LianHuaPanel
      {
         if(!_instance)
         {
            _instance = new LianHuaPanel();
         }
         return _instance;
      }
      
      public function set lianHuaVO(value:LianHuaVO) : void
      {
         this._lianHuaVO = value;
      }
      
      public function get lianHuaVO() : LianHuaVO
      {
         return this._lianHuaVO;
      }
      
      public function moveDi() : void
      {
         addEventListener(Event.ENTER_FRAME,this.en);
      }
      
      private function en(e:Event) : void
      {
      }
      
      public function getPanIndex(lvl:int) : void
      {
         var str:String = null;
         switch(lvl)
         {
            case 20:
               str = "一";
               break;
            case 22:
               str = "二";
               break;
            case 24:
               str = "三";
               break;
            case 25:
               str = "四";
               break;
            case 27:
               str = "五";
               break;
            case 28:
               str = "六";
               break;
            case 30:
               str = "七";
         }
         Global.delegate.dosomething(PetDiPanel.instance,PetDiPanel.instance.show);
         PetDiPanel.instance.update(str);
      }
      
      public function tuPoShow() : void
      {
         var i:int = 0;
         if(UIManager.petPanel.petVO.isTuPo == 0 && UIManager.petPanel.petVO.CZLevel >= 20)
         {
            i = 0;
            while(i < 3)
            {
               this.itemVec[i].visible = false;
               i++;
            }
            this.grid.count = CommandManager.get_bag_count(44751,2);
            this.lianHuaBtn.visible = false;
         }
         else
         {
            i = 0;
            while(i < 3)
            {
               this.itemVec[i].visible = true;
               i++;
            }
            this.lianHuaBtn.visible = true;
         }
         this.backLianHua.visible = this.lianHuaBtn.visible;
         this.tuPoBtn.visible = !this.lianHuaBtn.visible;
         this.backDi.visible = this.tuPoBtn.visible;
         this.numDi.visible = this.tuPoBtn.visible;
         this.openDi.visible = this.tuPoBtn.visible;
         this.DiTxt.visible = this.tuPoBtn.visible;
         this.grid.visible = this.tuPoBtn.visible;
         this.diSpr.visible = this.tuPoBtn.visible;
         if(this.diSpr.visible)
         {
            this.addDiSpriEff();
            this.diSpr.addEventListener(MouseEvent.MOUSE_OVER,this.removeDiSpriEff);
            this.diSpr.addEventListener(MouseEvent.MOUSE_OUT,this.addDiSpriEff);
         }
         else
         {
            this.removeDiSpriEff();
            this.diSpr.removeEventListener(MouseEvent.MOUSE_OVER,this.removeDiSpriEff);
         }
         this.lianHuaBG.visible = this.backLianHua.visible;
         this.lianHuaBM.visible = this.backLianHua.visible;
         this.chengZhangTxt.visible = this.backLianHua.visible;
      }
      
      private function addDiSpriEff(e:Object = null) : void
      {
         this.diSpr.filters = Util.glowBig000000;
      }
      
      private function removeDiSpriEff(e:Object = null) : void
      {
         this.diSpr.filters = [];
      }
      
      public function tuPoEff() : void
      {
         EffectManager.addEffect("35211",this.chengZhangSP,1500,0,-50);
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      protected function itemOnClick(event:MouseEvent) : void
      {
         var item:PetListItem = event.currentTarget as PetListItem;
         if(this.curItem == item)
         {
            return;
         }
         if(Boolean(this.curItem))
         {
            this.curItem.choose = false;
         }
         item.choose = true;
         this.curItem = item;
      }
      
      private function tupoHandler(e:MouseEvent) : void
      {
         if(CommandManager.get_bag_count(44751,2) >= 10)
         {
            PetCGMessage.CG_PET_TUPO();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("突破材料不足");
         }
      }
      
      public function addEffSuccess() : void
      {
         var property:Object = null;
         var step2:Function = function():void
         {
            var c:Bitmap = new Bitmap();
            c.bitmapData = chengZhangBM.bitmapData;
            addChild(c);
            ComponentUtil.setPropertie(c,{
               "x":chengZhangBM.x,
               "y":chengZhangBM.y
            });
            Tween.to(c,400,{
               "x":[c.x,c.x - c.width / 6],
               "y":[c.y,c.y - c.height / 6],
               "scaleX":[1,1.2],
               "scaleY":[1,1.2],
               "alpha":[1,0]
            },function(cc:Bitmap):void
            {
               removeChild(cc);
               cc = null;
            });
         };
         var b:Bitmap = new Bitmap();
         b.bitmapData = this.DiTxt.bitmapData;
         addChild(b);
         ComponentUtil.setPropertie(b,{
            "x":this.diSpr.x,
            "y":this.diSpr.y
         });
         property = {
            "x":this.chengZhangBM.x + this.chengZhangBM.width / 2,
            "y":this.chengZhangBM.y + this.chengZhangBM.height / 2
         };
         Tween.to(b,600,{
            "x":[b.x,b.x - b.width / 6],
            "y":[b.y,b.y - b.height / 6],
            "alpha":[1,0.8],
            "scaleX":[1,1.2],
            "scaleY":[1,1.2]
         },function(bb:Bitmap):void
         {
            Tween.to(bb,400,{
               "x":[bb.x,property.x - bb.width / 2],
               "y":[bb.y,property.y - bb.height / 2]
            },function(bbb:Bitmap):void
            {
               Tween.to(bbb,500,{
                  "scaleX":[1,0],
                  "scaleY":[1,0],
                  "x":[bbb.x,bbb.x + bbb.width / 2],
                  "y":[bbb.y,bbb.y + bbb.height / 2]
               },function(bbbb:Bitmap):void
               {
                  removeChild(bbbb);
                  bbbb = null;
                  step2();
               });
            });
         });
      }
      
      protected function lianHuaHandler(event:MouseEvent) : void
      {
         var vec:Vector.<Vo_valuable> = null;
         var isNo:Boolean = false;
         var i:uint = 0;
         if(UIManager.petPanel.petVO.CZLevel < 30)
         {
            vec = CommandManager.get_bag_vec(Enum_filter.ITEM_PET_GROW);
            isNo = false;
            i = 0;
            while(i < vec.length)
            {
               if(vec[i].id == this.curItem.data.id)
               {
                  isNo = true;
                  break;
               }
               i++;
            }
            if(isNo)
            {
               PetCGMessage.CG_PET_LIANHUA(vec[i].gridId);
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10056",1) + "</font>");
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10057",1) + "</font>");
         }
      }
      
      private function getColor(CZLevel:int) : String
      {
         if(CZLevel < 2)
         {
            return ColorConstant.getColorStr(ColorConstant.GREY);
         }
         if(CZLevel < 5)
         {
            return ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         if(CZLevel < 7)
         {
            return ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         if(CZLevel < 10)
         {
            return ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         if(CZLevel < 15)
         {
            return ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         if(CZLevel < 20)
         {
            return ColorConstant.getColorStr(ColorConstant.YELLOW);
         }
         if(CZLevel == 30)
         {
            return ColorConstant.getColorStr(ColorConstant.RED);
         }
         return ColorConstant.getColorStr(ColorConstant.ORANGE);
      }
      
      protected function hideKSGM(event:MouseEvent) : void
      {
      }
      
      public function update() : void
      {
         var path:String = null;
         var petVO:PetVO = UIManager.petPanel.petVO;
         var w:int = petVO.chengZhang > petVO.maxChengZhang ? this.WIDTH : int(petVO.chengZhang / petVO.maxChengZhang * this.WIDTH);
         this.lianHuaMask.width = w;
         this.chengZhangTxt.text = petVO.chengZhang + "/" + petVO.maxChengZhang;
         this.txtCZLevel.text = LangConfig.getWord("10054",1,petVO.CZLevel);
         this.updateItem();
         if(!petVO.isTuPo && petVO.CZLevel <= 20)
         {
            if(petVO.CZLevel < 2)
            {
               path = this.CZBMVec[0];
            }
            else if(petVO.CZLevel < 5)
            {
               path = this.CZBMVec[1];
            }
            else if(petVO.CZLevel < 7)
            {
               path = this.CZBMVec[2];
            }
            else if(petVO.CZLevel < 10)
            {
               path = this.CZBMVec[3];
            }
            else if(petVO.CZLevel < 15)
            {
               path = this.CZBMVec[4];
            }
            else if(petVO.CZLevel < 20)
            {
               path = this.CZBMVec[5];
            }
            else
            {
               path = this.CZBMVec[6];
            }
         }
         else if(Boolean(petVO.isTuPo))
         {
            if(petVO.CZLevel < 22)
            {
               path = this.CZBMVec[7];
            }
            else if(petVO.CZLevel < 24)
            {
               path = this.CZBMVec[8];
            }
            else if(petVO.CZLevel < 25)
            {
               path = this.CZBMVec[9];
            }
            else if(petVO.CZLevel < 27)
            {
               path = this.CZBMVec[10];
            }
            else if(petVO.CZLevel < 28)
            {
               path = this.CZBMVec[11];
            }
            else if(petVO.CZLevel < 30)
            {
               path = this.CZBMVec[12];
            }
            else
            {
               path = this.CZBMVec[13];
            }
         }
         else if(petVO.CZLevel < 22)
         {
            path = this.CZBMVec[6];
         }
         else if(petVO.CZLevel < 24)
         {
            path = this.CZBMVec[7];
         }
         else if(petVO.CZLevel < 25)
         {
            path = this.CZBMVec[8];
         }
         else if(petVO.CZLevel < 27)
         {
            path = this.CZBMVec[9];
         }
         else if(petVO.CZLevel < 28)
         {
            path = this.CZBMVec[10];
         }
         else if(petVO.CZLevel < 30)
         {
            path = this.CZBMVec[11];
         }
         else
         {
            path = this.CZBMVec[12];
         }
         if(petVO.CZLevel > 20)
         {
            this.chengZhangBM.transform.colorTransform = Util.colorGlow;
         }
         Utils.loadTitle("lang/ch/Pet_Imgs.swf",path,this.chengZhangBM);
         if(!petVO.isTuPo && petVO.CZLevel <= 20)
         {
            TipManager.bind(this.chengZhangSP,"<font color=\'" + (petVO.CZLevel > 1 ? this.getColor(2) : this.getColor(0)) + "\'>" + LangConfig.getWord("10063",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 4 ? this.getColor(5) : this.getColor(0)) + "\'>" + LangConfig.getWord("10064",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 6 ? this.getColor(7) : this.getColor(0)) + "\'>" + LangConfig.getWord("10065",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 9 ? this.getColor(10) : this.getColor(0)) + "\'>" + LangConfig.getWord("10066",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 14 ? this.getColor(15) : this.getColor(0)) + "\'>" + LangConfig.getWord("10649",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 19 ? this.getColor(20) : this.getColor(0)) + "\'>" + LangConfig.getWord("10650",1) + "</font>");
         }
         else if(petVO.CZLevel >= 20 && Boolean(petVO.isTuPo))
         {
            TipManager.bind(this.chengZhangSP,"<font color=\'" + (petVO.CZLevel >= 22 ? this.getColor(5) : this.getColor(0)) + "\'>" + LangConfig.getWord("10663",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel >= 24 ? this.getColor(7) : this.getColor(0)) + "\'>" + LangConfig.getWord("10664",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel >= 25 ? this.getColor(10) : this.getColor(0)) + "\'>" + LangConfig.getWord("10665",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel >= 27 ? this.getColor(15) : this.getColor(0)) + "\'>" + LangConfig.getWord("10666",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel >= 28 ? this.getColor(20) : this.getColor(0)) + "\'>" + LangConfig.getWord("10667",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel >= 30 ? this.getColor(30) : this.getColor(0)) + "\'>" + LangConfig.getWord("10668",1) + "</font>");
         }
         else if(petVO.CZLevel >= 20 && !petVO.isTuPo)
         {
            TipManager.bind(this.chengZhangSP,"<font color=\'" + (petVO.CZLevel > 22 ? this.getColor(5) : this.getColor(0)) + "\'>" + LangConfig.getWord("10663",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 24 ? this.getColor(7) : this.getColor(0)) + "\'>" + LangConfig.getWord("10664",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 25 ? this.getColor(10) : this.getColor(0)) + "\'>" + LangConfig.getWord("10665",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 27 ? this.getColor(15) : this.getColor(0)) + "\'>" + LangConfig.getWord("10666",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 28 ? this.getColor(20) : this.getColor(0)) + "\'>" + LangConfig.getWord("10667",1) + "</font>\n" + "<font color=\'" + (petVO.CZLevel > 30 ? this.getColor(30) : this.getColor(0)) + "\'>" + LangConfig.getWord("10668",1) + "</font>");
         }
      }
      
      private function updateItem() : void
      {
         var vec:Vector.<Vo_valuable> = null;
         var t:int = 0;
         var o:Object = null;
         var j:uint = 0;
         this.data = [];
         var i:uint = 0;
         while(i < 3)
         {
            vec = CommandManager.get_bag_vec(Enum_filter.ID,null,[idArr[i]]);
            t = 0;
            if(Boolean(vec))
            {
               j = 0;
               while(j < vec.length)
               {
                  t += vec[j].count;
                  j++;
               }
            }
            o = {
               "id":idArr[i],
               "total":t
            };
            this.itemVec[i].update(o);
            this.data.push(o);
            i++;
         }
      }
      
      public function selectItem(id:int) : void
      {
         if(Boolean(id))
         {
            this.itemVec[idArr.indexOf(id)].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function playEff() : void
      {
         if(!this.effSp)
         {
            this.effSp = new Sprite();
            addChild(this.effSp);
            this.effSp.scaleX = 0.6;
            this.effSp.scaleY = 0.6;
         }
         this.eff = EffectManager.addEffect("56918",this.effSp,600,200,70);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.lianHuaBG.bitmapData)
            {
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressLoading_board",this.lianHuaBG);
            }
            if(!this.lianHuaBM.bitmapData)
            {
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressLoading",this.lianHuaBM);
            }
            this.tuPoShow();
            if(Boolean(this.data[2].total))
            {
               this.itemVec[2].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            if(Boolean(this.data[1].total))
            {
               this.itemVec[1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            if(Boolean(this.data[0].total))
            {
               this.itemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            this.itemVec[2].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
}

