package com.yiTian.view.modules.cast.baishiZengyi
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CastCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_baoshiZY extends Panel123
   {
      
      public static const MAXLEVEL:int = 60;
      
      private static var isLoad:Boolean = false;
      
      private static const BAOSHIEFF:String = LangConfig.getWord("1144",0);
      
      public static var isFirstLoad:Boolean = true;
      
      private var grid:View_Grid;
      
      private var curEff:MyTextField;
      
      private var nextEff:MyTextField;
      
      private var lvlTxt:MyTextField;
      
      private var attTxt:MyTextField;
      
      private var attTxt_add:MyTextField;
      
      private var defTxt:MyTextField;
      
      private var defTxt_add:MyTextField;
      
      private var bloodTxt:MyTextField;
      
      private var bloodTxt_add:MyTextField;
      
      private var baoShangTxt:MyTextField;
      
      private var baoShangTxt_add:MyTextField;
      
      private var gongsuTxt:MyTextField;
      
      private var gongsuTxt_add:MyTextField;
      
      private var compareTxt:MyTextField;
      
      private var maskSpri:Sprite;
      
      private var att:int;
      
      private var defence:int;
      
      private var blood:int;
      
      private var baoShang:int;
      
      private var gongsu:int;
      
      private var posPointsArr:Array = [[176,92],[75,193],[277,193],[176,294]];
      
      private var maxWidth:int;
      
      private var eff:Effect;
      
      private var ownTxt:MyTextField;
      
      private var costTxt:MyTextField;
      
      private var curZY:int;
      
      public function View_baoshiZY()
      {
         super();
         init();
         regResource("lang/ch/DiamondGain_Imgs.swf","DiamondGain_Imgsdm");
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":596,
            "height":506
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":24,
            "y":40,
            "width":548,
            "height":456
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":484,
            "y":325,
            "width":48,
            "height":18
         },Global.Img_Cdm);
         move = new Rectangle(0,0,530,39);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":562,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
      }
      
      override protected function initUI2() : void
      {
         var progress:Bitmap;
         var hei:int;
         var vo:Vo_item;
         ComponentUtil.getScaleBitmap("Back_06",[2,2,1,1],this,{
            "x":359,
            "y":50,
            "width":203,
            "height":436
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_06",[2,2,1,1],this,{
            "x":34,
            "y":50,
            "width":320,
            "height":436
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_text",[5,5,1,1],this,{
            "x":39,
            "y":370,
            "width":310,
            "height":111
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Back_Diamond",this,{
            "x":44,
            "y":60
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Title_DiamondGain",this,{
            "x":218,
            "y":5
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Progress_Back_Diamond",this,{
            "x":43,
            "y":391
         },Global.DiamondGain_Imgsdm);
         progress = ComponentUtil.getBitmap("Progress_Diamond",this,{
            "x":64,
            "y":403
         },Global.DiamondGain_Imgsdm);
         this.maxWidth = progress.width;
         hei = progress.height;
         this.maskSpri = new Sprite();
         this.maskSpri.graphics.beginFill(0,0);
         this.maskSpri.graphics.drawRect(0,0,this.maxWidth,hei);
         this.maskSpri.graphics.endFill();
         ComponentUtil.setPropertie(this.maskSpri,{
            "x":64,
            "y":403
         });
         addChild(this.maskSpri);
         progress.mask = this.maskSpri;
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35172",this,600,64 - 5,410,true);
         }
         ComponentUtil.getScaleBitmap("Back_text",[5,5,1,1],this,{
            "x":369,
            "y":83,
            "width":183,
            "height":136
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_FanBi",[7,7,1,1],this,{
            "x":375,
            "y":61,
            "width":167,
            "height":36
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getTextField("注：消耗宝石水晶可提升宝石增益\n      等级，宝石等级越高加成的属\n      性也越多。",this,{
            "x":369,
            "y":354,
            "color":13416857,
            "size":12,
            "leading":4,
            "multiline":true,
            "wordWrap":true,
            "realWidth":192
         });
         ComponentUtil.getTextField("当前等级效果：",this,{
            "x":87,
            "y":431,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.curEff = ComponentUtil.getTextField("宝石效果+00%",this,{
            "x":87,
            "y":450,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("下一等级效果：",this,{
            "x":214,
            "y":431,
            "color":52224,
            "size":12,
            "leading":0
         });
         this.nextEff = ComponentUtil.getTextField("宝石效果+00%",this,{
            "x":214,
            "y":450,
            "color":52224,
            "size":12,
            "leading":0
         });
         this.lvlTxt = ComponentUtil.getTextField("Lv.000",this,{
            "x":176,
            "y":375,
            "color":16383744,
            "size":12,
            "leading":0,
            "bold":true
         });
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":488,
            "y":333,
            "width":50,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField("拥有宝石水晶：",this,{
            "x":396,
            "y":310,
            "color":13416857,
            "size":12,
            "leading":0
         });
         this.ownTxt = ComponentUtil.getTextField("1",this,{
            "x":488,
            "y":310,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("消耗宝石水晶：",this,{
            "x":396,
            "y":335,
            "color":13416857,
            "size":12,
            "leading":0
         });
         this.costTxt = ComponentUtil.getTextField("0",this,{
            "x":488,
            "y":335,
            "color":16777215,
            "size":12,
            "leading":0,
            "type":TextFieldType.INPUT,
            "restrict":"0-9",
            "maxChars":3,
            "realWidth":60,
            "realHeight":19
         });
         this.costTxt.addEventListener(Event.CHANGE,this.changeHd);
         this.costTxt.addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void
         {
            if(costTxt.text == "" || costTxt.text == "0")
            {
               costTxt.text = "0";
            }
         });
         ComponentUtil.getButton("","Button_NumUp",this,{
            "x":518,
            "y":334,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               var nn:* = int(costTxt.text);
               nn++;
               if(nn >= int(ownTxt.text))
               {
                  nn = int(ownTxt.text);
               }
               costTxt.text = nn.toString();
            }
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_NumDown",this,{
            "x":518,
            "y":344,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               var nn:* = int(costTxt.text);
               nn--;
               if(nn <= 1)
               {
                  nn = 0;
               }
               costTxt.text = nn.toString();
            }
         },Global.Img_Cdm);
         this.compareTxt = ComponentUtil.getTextField("000/000",this,{
            "x":173,
            "y":402,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.attTxt = ComponentUtil.getTextField("000",this,{
            "x":425,
            "y":100,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.attTxt_add = ComponentUtil.getTextField("+000",this,{
            "x":483,
            "y":100,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.defTxt = ComponentUtil.getTextField("000",this,{
            "x":425,
            "y":122,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.defTxt_add = ComponentUtil.getTextField("+000",this,{
            "x":483,
            "y":122,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.bloodTxt = ComponentUtil.getTextField("000",this,{
            "x":425,
            "y":144,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.bloodTxt_add = ComponentUtil.getTextField("+000",this,{
            "x":483,
            "y":144,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.baoShangTxt = ComponentUtil.getTextField("000",this,{
            "x":425,
            "y":166,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.baoShangTxt_add = ComponentUtil.getTextField("+000",this,{
            "x":483,
            "y":166,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.gongsuTxt = ComponentUtil.getTextField("000",this,{
            "x":425,
            "y":188,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.gongsuTxt_add = ComponentUtil.getTextField("+000",this,{
            "x":483,
            "y":188,
            "color":15049739,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         ComponentUtil.setPropertie(this.grid,{
            "x":440,
            "y":260
         });
         addChild(this.grid);
         vo = new Vo_item();
         vo.id = 44477;
         vo.Init_lib();
         this.grid.vo = vo;
         ComponentUtil.getBitmap("Text_GongJi",this,{
            "x":379,
            "y":100
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Text_QiXue",this,{
            "x":379,
            "y":144
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Text_FangYu",this,{
            "x":379,
            "y":122
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Text_BaoShang",this,{
            "x":379,
            "y":166
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Text_FanBi",this,{
            "x":385,
            "y":66
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Text_CaiLiao",this,{
            "x":400,
            "y":220
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getBitmap("Text_GongSu",this,{
            "x":379,
            "y":188
         },Global.DiamondGain_Imgsdm);
         ComponentUtil.getButton("","Button_XiangKe",this,{
            "x":411,
            "y":424,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               cliHd();
            }
         },Global.DiamondGain_Imgsdm);
         this.updateCur();
         isFirstLoad = false;
         this.stonePos();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.update);
            Global.control.registerCallBack(Enum_MsgType.ROLE_UPDATE,this.updateEquip);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.update);
            Global.control.removeCallBack(Enum_MsgType.ROLE_UPDATE,this.updateEquip);
         }
      }
      
      private function reset() : void
      {
         this.att = 0;
         this.defence = 0;
         this.blood = 0;
         this.baoShang = 0;
         this.gongsu = 0;
      }
      
      private function stonePos() : void
      {
         var spr:Sprite = null;
         var posA:Array = null;
         var sp:Sprite = null;
         spr = new Sprite();
         spr.graphics.beginFill(0,0);
         spr.graphics.drawRect(0,0,65,65);
         spr.graphics.endFill();
         spr.x = 161;
         spr.y = 177;
         addChild(spr);
         ComponentUtil.getBitmap("bsZY65",spr,null,Global.DiamondGain_Imgsdm);
         var i:int = 0;
         while(i < this.posPointsArr.length)
         {
            posA = this.posPointsArr[i];
            sp = new Sprite();
            sp.graphics.beginFill(0,0);
            sp.graphics.drawRect(0,0,40,40);
            sp.graphics.endFill();
            sp.x = posA[0];
            sp.y = posA[1];
            addChild(sp);
            ComponentUtil.getBitmap("bsZY34",sp,null,Global.DiamondGain_Imgsdm);
            i++;
         }
      }
      
      private function changeHd(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) >= int(this.ownTxt.text))
         {
            tf.text = this.ownTxt.text;
         }
         if(tf.text == "0")
         {
            tf.text = "1";
         }
      }
      
      private function cliHd() : void
      {
         if(int(this.ownTxt.text) == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1154",0));
            return;
         }
         if(int(this.costTxt.text) == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1155",0));
            return;
         }
         CastCGMessage.CG_BAISHI_QIANKE(int(this.costTxt.text));
      }
      
      public function wordsEff(sLvl:int) : void
      {
         var effTf:MyTextField = ComponentUtil.getTextField("Lv." + sLvl,this,{
            "x":this.lvlTxt.x,
            "y":this.lvlTxt.y,
            "bold":true,
            "size":12,
            "color":16383744
         });
         Tween.to(effTf,400,{
            "scaleX":[1,2],
            "scaleY":[1,2],
            "x":[this.lvlTxt.x,this.lvlTxt.x - this.lvlTxt.width / 2],
            "y":[this.lvlTxt.y,this.lvlTxt.y - this.lvlTxt.height / 2],
            "alpha":[1,0]
         },function(efTf:MyTextField):void
         {
            if(Boolean(efTf) && Boolean(efTf.parent))
            {
               efTf.parent.removeChild(efTf);
            }
            efTf = null;
         });
      }
      
      public function getSeEff() : void
      {
         EffectManager.addEffect("35174",this,800,43.6 + 150,60 + 150);
      }
      
      private function update() : void
      {
         if(Boolean(this.ownTxt))
         {
            this.ownTxt.text = CommandManager.get_bag_count(44477).toString();
         }
      }
      
      private function updateEquip() : void
      {
         var i:int = 0;
         var __vo:Vo_equip = null;
         var j:int = 0;
         var id:int = 0;
         var typeIn:int = 0;
         var result:int = 0;
         var typeIn2:int = 0;
         var result2:int = 0;
         var vec:Vector.<View_Grid> = UIManager.rolePanel.view_role_equip.get_equips_noFasion();
         this.reset();
         if(Boolean(vec))
         {
            i = 0;
            while(i < vec.length)
            {
               __vo = vec[i].vo as Vo_equip;
               j = 0;
               while(j < __vo.vec_gemId.length)
               {
                  id = __vo.vec_gemId[j];
                  if(id == 0)
                  {
                     j++;
                  }
                  else
                  {
                     if(Boolean(id))
                     {
                        typeIn = int(Data_lib.item[id][Enum_lib_item.TYPE_RESULT]);
                        result = int(Data_lib.item[id][Enum_lib_item.RESULT]);
                        typeIn2 = int(Data_lib.item[id][Enum_lib_item.SED_TYPE_RESULT]);
                        result2 = int(Data_lib.item[id][Enum_lib_item.SED_RESULT]);
                     }
                     if(typeIn == 1)
                     {
                        this.att += result;
                     }
                     else if(typeIn == 2)
                     {
                        this.defence += result;
                     }
                     else if(typeIn == 4)
                     {
                        this.blood += result;
                     }
                     else if(typeIn == 10)
                     {
                        this.baoShang += result;
                     }
                     else if(typeIn == 13)
                     {
                        this.gongsu += result;
                     }
                     if(result2 != 0)
                     {
                        if(typeIn2 == 1)
                        {
                           this.att += result2;
                        }
                        else if(typeIn2 == 2)
                        {
                           this.defence += result2;
                        }
                        else if(typeIn2 == 4)
                        {
                           this.blood += result2;
                        }
                        else if(typeIn2 == 10)
                        {
                           this.baoShang += result2;
                        }
                        else if(typeIn2 == 13)
                        {
                           this.gongsu += result2;
                        }
                     }
                     j++;
                  }
               }
               i++;
            }
         }
         this.attTxt.text = this.att.toString();
         this.attTxt_add.htmlText = HtmlUtil.font("+" + int(this.att * this.curZY / 100),"#04ff00");
         this.defTxt.text = this.defence.toString();
         this.defTxt_add.htmlText = HtmlUtil.font("+" + int(this.defence * this.curZY / 100),"#04ff00");
         this.bloodTxt.text = this.blood.toString();
         this.bloodTxt_add.htmlText = HtmlUtil.font("+" + int(this.blood * this.curZY / 100),"#04ff00");
         this.baoShangTxt.text = this.baoShang.toString();
         this.baoShangTxt_add.htmlText = HtmlUtil.font("+" + int(this.baoShang * this.curZY / 100),"#04ff00");
         this.gongsuTxt.text = this.gongsu.toString();
         this.gongsuTxt_add.htmlText = HtmlUtil.font("+" + int(this.gongsu * this.curZY / 100),"#04ff00");
      }
      
      private function updateCur() : void
      {
         var cur:int = Vo_baoshiZY.curLvl;
         var max:int = Vo_baoshiZY.maxLvl;
         var curW:int = this.maskSpri.width;
         var changedW:int = this.maxWidth * (cur / max);
         Tween.to(this.maskSpri,50,{"width":[curW,changedW]});
         var chanX:int = this.maskSpri.x + changedW;
         Tween.to(this.eff,50,{"px":[this.eff.px,chanX - 7]});
         this.compareTxt.text = cur + "/" + max;
         if(int(this.costTxt.text) >= int(this.ownTxt.text))
         {
            this.costTxt.text = this.ownTxt.text;
         }
         if(this.costTxt.text == "0")
         {
            this.costTxt.text = "1";
         }
         this.ownTxt.text = CommandManager.get_bag_count(44477).toString();
         this.updateEquip();
      }
      
      public function updata(lvl:int) : void
      {
         if(!visible)
         {
            this.visible = true;
         }
         if(lvl > 0)
         {
            this.curZY = Data_lib.baoshi[lvl][1];
            this.curEff.text = BAOSHIEFF + this.curZY + "%";
            if(lvl >= MAXLEVEL)
            {
               this.nextEff.text = BAOSHIEFF + this.curZY + "%";
            }
            else
            {
               this.nextEff.text = BAOSHIEFF + Data_lib.baoshi[lvl + 1][1] + "%";
            }
         }
         else
         {
            this.curZY = lvl;
            this.curEff.text = BAOSHIEFF + this.curZY + "%";
            this.nextEff.text = BAOSHIEFF + Data_lib.baoshi[lvl + 1][1] + "%";
         }
         this.lvlTxt.text = "Lv." + lvl;
         if(!isFirstLoad)
         {
            this.updateCur();
         }
      }
      
      override public function resetPosition() : void
      {
         var xp:Number = NaN;
         var yp:Number = NaN;
         var _xp:Number = NaN;
         var _yp:Number = NaN;
         var pan:View_rolePan = Singleton.getInstance(View_rolePan);
         if(pan.visible)
         {
            xp = Global.stage.stageWidth / 2;
            yp = (Global.stage.stageHeight - height) / 2;
            Tween.to(pan,100,{
               "x":[pan.x,xp - 475],
               "y":[pan.y,yp]
            });
            x = xp + 10;
            y = yp;
         }
         else if((Singleton.getInstance(View_rolePan) as View_rolePan).visible)
         {
            _xp = Global.stage.stageWidth / 2;
            _yp = (Global.stage.stageHeight - height) / 2;
            Tween.to(pan,100,{
               "x":[pan.x,_xp - 475],
               "y":[pan.y,_yp]
            });
            x = _xp + 10;
            y = _yp;
         }
         else
         {
            x = (Global.stage.stageWidth - 440) / 2;
            y = (Global.stage.stageWidth - 1130) / 2;
         }
      }
   }
}

