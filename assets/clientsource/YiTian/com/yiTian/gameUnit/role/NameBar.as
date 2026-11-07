package com.yiTian.gameUnit.role
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.baby.babyManager.Enum_baby;
   import com.yiTian.view.modules.role.View_role_equip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class NameBar extends Sprite
   {
      
      private var tf:MyTextField;
      
      private var unit:GameUnit;
      
      private var data:Dictionary = new Dictionary();
      
      private var pool:Array = [];
      
      private var LZbmp:LZBmp = new LZBmp();
      
      private var isYearHz:int;
      
      private var xinYueBmp:Bitmap;
      
      private var xinYueLvl:int;
      
      private var isShow:int;
      
      private var testTF:MyTextField;
      
      private var tsTF2:MyTextField;
      
      private var isSuperH:int = 0;
      
      private var isHuangZYear:int = 0;
      
      private var pet_type_bmp:Bitmap;
      
      private var buffIconArray:Array;
      
      private var xunZhangBm:Bitmap2;
      
      protected var _needApplyShow:Boolean = false;
      
      private var _nameBarGroup:HGroup2 = new HGroup2(0,-23,100,100,-30,0);
      
      public var chenghaoLayer:Sprite;
      
      public function NameBar(unit:GameUnit)
      {
         super();
         this.unit = unit;
         this.tf = ComponentUtil.getTextField(" ",this,{
            "align":"center",
            "mouseEnabled":false,
            "multiline":true,
            "leading":2
         });
         addChild(this.LZbmp);
         this.chenghaoLayer = new Sprite();
         addChild(this.chenghaoLayer);
      }
      
      public function addDia(diaLvl:int, isYearDia:int, hzLv:int = 0, isHzYear:int = 0, isHuiyuan:int = 0, isHuiyuanYear:int = 0, superLan:int = 0, superLanYear:int = 0, isSuperH:int = 0) : void
      {
         this.LZbmp.bitmapData = null;
         if(Global.pf == "qqgame" || Global.pf == Enum_SPStr.QQ3366)
         {
            if(superLanYear == 0 && superLan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getsuperLan(superLan),this.LZbmp.bmp,null,function():void
               {
                  align(2);
               });
               return;
            }
            if(superLan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getsuperLanYear(superLan),this.LZbmp.bmp,null,function():void
               {
                  align(2);
               });
               return;
            }
            if(isYearDia == 0 && diaLvl > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl(diaLvl),this.LZbmp.bmp,null,function():void
               {
                  align(2);
               });
            }
            else if(diaLvl > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl(diaLvl),this.LZbmp.bmp,null,function():void
               {
                  align(2);
               });
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isPartUnion() || Enum_SPStr.isUnion(Global.pf))
         {
            if(isHuiyuanYear == 0 && isHuiyuan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getQQHuiYuan(isHuiyuan),this.LZbmp.bmp,null,function():void
               {
                  align(0);
               });
            }
            else if(isHuiyuan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getQQHuiYuanYear(isHuiyuan),this.LZbmp.bmp,null,function():void
               {
                  align(0);
               });
            }
            if(Global.pf == Enum_SPStr.GUANWANG)
            {
               this.align(0);
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(!isSuperH)
            {
               this.isYearHz = isHzYear;
               if(isHzYear == 0 && hzLv > 0)
               {
                  this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl_h(hzLv),this.LZbmp.bmp,null,function():void
                  {
                     align(2);
                  });
               }
               else if(hzLv > 0)
               {
                  this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl_h(hzLv),this.LZbmp.bmp,null,function():void
                  {
                     align(2);
                  });
               }
            }
            else
            {
               this.isYearHz = isHzYear;
               if(isHzYear == 0 && hzLv > 0)
               {
                  this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl_superH(hzLv),this.LZbmp.bmp,null,function():void
                  {
                     align(2);
                  });
               }
               else if(hzLv > 0)
               {
                  this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl_superH(hzLv),this.LZbmp.bmp,null,function():void
                  {
                     align(2);
                  });
               }
            }
         }
      }
      
      private function align(_sp:int = 0) : void
      {
         if(Global.pf != "qqgame")
         {
            if(this.isYearHz == 0)
            {
               this.LZbmp.x = -this.tf.width / 2 - 3;
            }
            else
            {
               this.LZbmp.x = -this.tf.width / 2;
            }
         }
         else
         {
            this.LZbmp.x = -this.tf.width / 2;
         }
         this.LZbmp.y = this.tf.y + this.tf.height - 18 + _sp;
         if(Global.pf == Enum_SPStr.GUANWANG)
         {
            if(Boolean(this.xinYueBmp))
            {
               this.xinYueBmp.bitmapData = null;
               if(contains(this.xinYueBmp))
               {
                  removeChild(this.xinYueBmp);
               }
            }
            if(Boolean(this.xinYueLvl))
            {
               this.xinYueBmp = Utils.getLoadBitmap("resource/image/Diamond/xinYueIcon.png",this.xinYueBmp,null,this.comAlign);
               addChild(this.xinYueBmp);
            }
            if(SceneConfig.getSceneType() == SceneConfig.KUNLUN)
            {
               if(Boolean(this.xinYueBmp))
               {
                  this.xinYueBmp.visible = false;
               }
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            this.LZbmp.x = this.tf.x + this.tf.textWidth + 8;
         }
      }
      
      public function set isShw(value:int) : void
      {
         this.isShow = value;
         if(value == 1)
         {
            if(Boolean(this.xinYueBmp))
            {
               this.xinYueBmp.visible = true;
            }
         }
         else if(value == 0)
         {
            if(Boolean(this.xinYueBmp))
            {
               this.xinYueBmp.visible = false;
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.KUNLUN)
         {
            if(Boolean(this.xinYueBmp))
            {
               this.xinYueBmp.visible = false;
            }
         }
      }
      
      private function comAlign() : void
      {
         var nn1:int = 0;
         var weiT1:int = 0;
         var weiT2:int = 0;
         nn1 = this.tf.x + this.tf.width / 2;
         var nn2:int = nn1 - this.testTF.textWidth / 2;
         var nn3:int = nn2 - this.LZbmp.width;
         if(GameUnitManager.hero.vip > 0)
         {
            weiT1 = 11;
            weiT2 = 11;
         }
         else
         {
            weiT1 = 1;
            weiT2 = 1;
         }
         this.LZbmp.x = nn3 - weiT1;
         var nn4:int = nn1 + this.testTF.textWidth / 2;
         if(Boolean(this.xinYueBmp))
         {
            this.xinYueBmp.x = nn4 + weiT2;
            this.xinYueBmp.y = this.LZbmp.y;
            if(this.isShow == 1)
            {
               this.xinYueBmp.visible = true;
            }
            else
            {
               this.xinYueBmp.visible = false;
            }
         }
      }
      
      private function getSpace(diaLvl:int, isYear:int, huangZLv:int, isHuangZYear:int, huiyuan:int = 0, isHuiYuanYear:int = 0, superLan:int = 0, superLanYear:int = 0) : String
      {
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            return "";
         }
         if(Global.pf == "qqgame")
         {
            if(Boolean(superLanYear) && superLan > 0)
            {
               return "        ";
            }
            if(superLan > 0)
            {
               return "    ";
            }
            if(Boolean(isYear) && diaLvl > 0)
            {
               return "         ";
            }
            if(diaLvl > 0)
            {
               return "    ";
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            if(Boolean(isHuiYuanYear) && huiyuan > 0)
            {
               if(Global.pf == Enum_SPStr.GUANWANG)
               {
                  if(Boolean(this.xinYueLvl))
                  {
                     return "";
                  }
               }
               return "            ";
            }
            if(huiyuan > 0)
            {
               if(Global.pf == Enum_SPStr.GUANWANG)
               {
                  if(Boolean(this.xinYueLvl))
                  {
                     return "";
                  }
               }
               return "          ";
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Boolean(isHuangZYear) && huangZLv > 0)
            {
               return "          ";
            }
            if(huangZLv > 0)
            {
               return "     ";
            }
         }
         return "";
      }
      
      public function show() : void
      {
         this.invalidate();
         this._needApplyShow = true;
         visible = true;
      }
      
      private function showRender(e:Event) : void
      {
         var player:Player = null;
         var _PlayerName:String = null;
         var jobWayLabel:String = null;
         var npc:Npc = null;
         var p:Pet = null;
         var partnerName:String = null;
         var partner:GameUnit = null;
         var strChengHao:String = null;
         var vipStr:String = null;
         var j:* = undefined;
         var i:int = 0;
         var skillId:int = 0;
         var temNum:int = 0;
         this._needApplyShow = false;
         if(!this.testTF)
         {
            this.testTF = ComponentUtil.getTextField("",this);
            this.testTF.visible = false;
         }
         if(!this.tsTF2)
         {
            this.tsTF2 = ComponentUtil.getTextField("",this);
            this.tsTF2.visible = false;
         }
         if(!this.unit)
         {
            return;
         }
         if(this.unit is HunLi)
         {
            this.setText(HtmlUtil.font(Model_heFu.repNameUseSerID(this.unit.name),"#FF0000"));
            this.align();
            visible = true;
            return;
         }
         if(Boolean(this.LZbmp))
         {
            this.LZbmp.bitmapData = null;
         }
         if(Boolean(this.pet_type_bmp))
         {
            this.pet_type_bmp.bitmapData = null;
         }
         switch(this.unit.type)
         {
            case UnitType.PLAYER:
               player = this.unit as Player;
               _PlayerName = player.name;
               jobWayLabel = SceneConfig.getSceneType() == SceneConfig.KUNLUN && GameUnitManager.hero != this.unit ? "" : Enum_job.getJobWayLabel(player.job,true);
               _PlayerName = Model_heFu.repNameByHero(_PlayerName);
               this.testTF.text = _PlayerName;
               this.xinYueLvl = player.xinYueLvl;
               this.isShow = player.isShow;
               this.isSuperH = player.isSuperHuang;
               this.isHuangZYear = player.isHuangZuanYear;
               if(player.status == Status.KUN_LUN && player.id != GameUnitManager.hero.id)
               {
                  this.setText(HtmlUtil.font(_PlayerName,"#FF0000") + jobWayLabel);
                  this.addDia(0,0);
                  this.addXunZhang(0,0);
               }
               else if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
               {
                  this.setText(Model_heFu.repNameUseSerID(_PlayerName));
                  this.LZbmp.bitmapData = null;
                  if(Boolean(player.campId))
                  {
                     this.addDia(0,0);
                     this.addXunZhang(0,0);
                     this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getCamp(player.campId),this.LZbmp.bmp,null,function():void
                     {
                        align(-2);
                     });
                     return;
                  }
               }
               else if(player.status == Status.AiDeBaoBao_Bao)
               {
                  partner = GameUnitManager.findUnit(player.AiDeBaoBao_partner,UnitType.PLAYER);
                  if(Boolean(partner))
                  {
                     partnerName = partner.name;
                     if(player.sex == 1)
                     {
                        this.setText("<font color=\'#04aeee\'>" + Model_heFu.repNameByHero(_PlayerName) + "</font> & <font color=\'#b64ffb\'>" + Model_heFu.repNameByHero(partnerName) + "</font>");
                     }
                     else
                     {
                        this.setText("<font color=\'#04aeee\'>" + Model_heFu.repNameByHero(partnerName) + "</font> & <font color=\'#b64ffb\'>" + Model_heFu.repNameByHero(_PlayerName) + "</font>");
                     }
                  }
                  else
                  {
                     this.setText(Model_heFu.repNameByHero(_PlayerName));
                  }
                  this.addDia(0,0);
                  this.addXunZhang(0,0);
               }
               else
               {
                  strChengHao = "";
                  if(Boolean(player.chengHao))
                  {
                     strChengHao = HtmlUtil.fontBr(Data_lib.chengHao[player.chengHao][View_role_equip.TITLE],ColorConstant.getColorStr(View_role_equip.vecColor[Data_lib.chengHao[player.chengHao][View_role_equip.COLOR] - 1]));
                  }
                  vipStr = "";
                  if(Boolean(player.vip))
                  {
                     vipStr = HtmlUtil.fontNoSize("[魂]",Model_shop.get_color_arr[player.vip]);
                     this.testTF.text = Model_heFu.repNameByHero(_PlayerName) + "[魂]";
                  }
                  if(player.party != "")
                  {
                     this.setText(strChengHao + HtmlUtil.fontBr(LangConfig.getWord("10539",1) + player.party,ColorConstant.getColorStr(20)) + HtmlUtil.font(this.getSpace(player.ylDiaLvl,player.isYearDia,player.huangZuanLvl,player.isHuangZuanYear,player.isHuiyuan,player.isHuiyuanYear,player.superLan,player.superLanYear) + Model_heFu.repNameByHero(_PlayerName),ColorConstant.getColorStr(37)) + vipStr + jobWayLabel);
                  }
                  else
                  {
                     this.setText(HtmlUtil.fontBr(strChengHao + LangConfig.getWord("10540",1),ColorConstant.getColorStr(7)) + HtmlUtil.font(this.getSpace(player.ylDiaLvl,player.isYearDia,player.huangZuanLvl,player.isHuangZuanYear,player.isHuiyuan,player.isHuiyuanYear,player.superLan,player.superLanYear) + Model_heFu.repNameByHero(_PlayerName),ColorConstant.getColorStr(37)) + vipStr + jobWayLabel);
                  }
                  this.tsTF2.htmlText = strChengHao;
                  this.addXunZhang(this.tsTF2.textWidth,player.xunZhangLv);
                  if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf) || Enum_SPStr.isIwan(Global.pf))
                  {
                     if(SceneConfig.getSceneType() != SceneConfig.KUNLUN)
                     {
                        this.addDia(player.ylDiaLvl,player.isYearDia,player.huangZuanLvl,player.isHuangZuanYear,player.isHuiyuan,player.isHuiyuanYear,player.superLan,player.superLanYear,player.isSuperHuang);
                     }
                  }
               }
               if(Boolean(Global.ADBB_Imgsdm) && Boolean(player.AiDeBaoBao_buff) && player.AiDeBaoBao_buff.length > 0)
               {
                  if(!this.buffIconArray)
                  {
                     this.buffIconArray = [];
                     this.buffIconArray.push(ComponentUtil.getBitmap("Skill_buff_1",this,{"visible":false},Global.ADBB_Imgsdm));
                     this.buffIconArray.push(ComponentUtil.getBitmap("Skill_buff_2",this,{"visible":false},Global.ADBB_Imgsdm));
                     this.buffIconArray.push(ComponentUtil.getBitmap("Skill_buff_3",this,{"visible":false},Global.ADBB_Imgsdm));
                     this.buffIconArray.push(ComponentUtil.getBitmap("Skill_buff_4",this,{"visible":false},Global.ADBB_Imgsdm));
                  }
                  for(j in this.buffIconArray)
                  {
                     this.buffIconArray[j].visible = false;
                  }
                  if(player.AiDeBaoBao_buff[0] == "")
                  {
                     break;
                  }
                  i = 0;
                  while(i < player.AiDeBaoBao_buff.length)
                  {
                     skillId = int(player.AiDeBaoBao_buff[i]);
                     this.buffIconArray[skillId - 1].visible = true;
                     this.buffIconArray[skillId - 1].x = i * 15 - 15 * player.AiDeBaoBao_buff.length / 2;
                     this.buffIconArray[skillId - 1].y = 25;
                     i++;
                  }
               }
               break;
            case UnitType.NPC:
               npc = this.unit as Npc;
               if(npc.name == "0")
               {
                  npc.name = "";
               }
               if(npc.npcType == Enum_npc_type.BANGPLANT)
               {
                  temNum = npc.mode;
                  if(temNum == 1)
                  {
                     temNum = 2;
                  }
                  if(npc.mode == 1)
                  {
                     this.setText(HtmlUtil.font("西瓜藤",Model_shop.get_color_arr[temNum - 2]));
                     break;
                  }
                  if(npc.mode == 2)
                  {
                     this.setText(HtmlUtil.font("西瓜",Model_shop.get_color_arr[temNum - 2]));
                     break;
                  }
                  if(npc.mode == 3)
                  {
                     this.setText(HtmlUtil.font("西瓜",Model_shop.get_color_arr[temNum - 2]));
                     break;
                  }
                  if(npc.mode == 4)
                  {
                     this.setText(HtmlUtil.font("西瓜",Model_shop.get_color_arr[temNum - 2]));
                     break;
                  }
                  if(npc.mode == 5)
                  {
                     this.setText(HtmlUtil.font("西瓜",Model_shop.get_color_arr[temNum - 2]));
                     break;
                  }
                  if(npc.mode == 6)
                  {
                     this.setText(HtmlUtil.font("西瓜",Model_shop.get_color_arr[temNum - 2]));
                  }
                  break;
               }
               if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
               {
                  if(Enum_npc_type.canBattle(npc.npcType))
                  {
                     this.setText(HtmlUtil.font(npc.name,"#FF0000"));
                     break;
                  }
                  this.setText(npc.name);
                  break;
               }
               if(Enum_npc_type.canBattle(npc.npcType))
               {
                  this.setText(HtmlUtil.font(npc.name,"#FF0000"));
                  break;
               }
               if(npc.official != null && npc.official != "0")
               {
                  this.setText(HtmlUtil.font(npc.official + "\n" + npc.name,ColorConstant.getColorStr(4)));
                  break;
               }
               this.setText(HtmlUtil.font(npc.name,ColorConstant.getColorStr(4)));
               break;
            case UnitType.PET:
               p = this.unit as Pet;
               if(!this.pet_type_bmp)
               {
                  this.pet_type_bmp = new Bitmap();
                  addChild(this.pet_type_bmp);
                  ComponentUtil.setPropertie(this.pet_type_bmp,{
                     "y":-40,
                     "x":-62
                  });
               }
               if(p.pet_type > 0 && Enum_baby.zinvId.indexOf(p.body) == -1)
               {
                  Utils.getLoadBitmap("resource/image/pet/pet_0" + p.pet_type + ".png",this.pet_type_bmp);
               }
               if(p.body == 20906 || p.body == 20907 || p.body == 20908)
               {
                  if(Global.pf == "qqgame" || Global.pf == "3366")
                  {
                     if(this.unit.name == "麒麟")
                     {
                        this.unit.name = "布鲁";
                     }
                     this.setText(HtmlUtil.font(this.unit.name,p.zhizi) + "<font color=\'#33CCFF\'>【" + LangConfig.getWord("10629",1,"蓝钻") + "】</font>");
                     break;
                  }
                  if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
                  {
                     this.setText(HtmlUtil.font(this.unit.name,p.zhizi) + "<font color=\'#f9ff00\'>【" + LangConfig.getWord("10629",1,"会员") + "】</font>");
                     break;
                  }
                  this.setText(HtmlUtil.font(this.unit.name,p.zhizi) + "<font color=\'#FFFF00\'>【" + LangConfig.getWord("10629",1,"黄钻") + "】</font>");
                  break;
               }
               this.setText(HtmlUtil.font(this.unit.name,p.zhizi));
         }
      }
      
      private function addXunZhang(_width:int, _ch:int) : void
      {
         if(!this.xunZhangBm)
         {
            this.xunZhangBm = new Bitmap2();
            addChild(this.xunZhangBm);
         }
         if(_ch == 0)
         {
            this.xunZhangBm.load(null);
            return;
         }
         ComponentUtil.setPropertie(this.xunZhangBm,{
            "x":this.tf.x + this.tf.textWidth / 2 + 26,
            "y":this.tf.y - 3
         });
         var _ss:String = "";
         if(_ch < 10)
         {
            _ss = "00" + _ch;
         }
         else
         {
            _ss = "0" + _ch;
         }
         this.xunZhangBm.load("resource/image/xunZhang/" + _ss + ".png");
         if(SceneConfig.getSceneType() == SceneConfig.KUNLUN)
         {
            this.xunZhangBm.visible = false;
         }
         else
         {
            this.xunZhangBm.visible = true;
         }
      }
      
      private function setText(text:String) : void
      {
         this.tf.htmlText = text;
         this.tf.x = -this.tf.width / 2;
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function invalidate() : void
      {
         addEventListener(Event.ENTER_FRAME,this._render);
      }
      
      private function _render(e:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this._render);
         if(this._needApplyShow)
         {
            this.showRender(e);
         }
      }
      
      public function appendItem(item:Object, lay:Sprite = null) : void
      {
         if(lay == null)
         {
            lay = this.chenghaoLayer;
         }
         this._nameBarGroup.appendItem(item);
         if(item is DisplayObject)
         {
            lay.addChild(item as DisplayObject);
         }
      }
      
      public function removeItem(item:Object) : void
      {
         if(!this._nameBarGroup)
         {
            return;
         }
         this._nameBarGroup.dependItem(item);
         if(item is Effect)
         {
            EffectManager.removeEffect(item as Effect);
         }
      }
      
      public function groupClear() : void
      {
         var item:Object = null;
         if(!this._nameBarGroup)
         {
            return;
         }
         var items:Array = this._nameBarGroup.getItems();
         for each(item in items)
         {
            if(item is DisplayObject && Boolean(item.parent))
            {
               item.parent.removeChild(item as DisplayObject);
            }
            if(item is Effect)
            {
               EffectManager.removeEffect(item as Effect);
            }
         }
         if(Boolean(this._nameBarGroup))
         {
            this._nameBarGroup.clearItem();
         }
      }
      
      public function groupAlign() : void
      {
         if(Boolean(this._nameBarGroup))
         {
            this._nameBarGroup.align();
         }
      }
      
      public function addChengHaoEff(sID:String, totalTime:int = 3000) : Effect
      {
         var eff:Effect = EffectManager.addEffect(sID,null,totalTime,-5,0,true);
         this.appendItem(eff);
         return eff;
      }
   }
}

import Layout.HGroup;
import Layout.ILayout;
import com.yiTian.gameUnit.magic.Effect;

class HGroup2 extends HGroup
{
   
   public function HGroup2(xx:Number, yy:Number, w:Number, h:Number, iH:Number, iInterval:Number)
   {
      super(xx,yy,w,h,iH,iInterval);
   }
   
   public function getItems() : Array
   {
      return itemArr;
   }
   
   override public function align() : void
   {
      var i:int = 0;
      var __y:Number = NaN;
      var len:int = int(itemArr.length);
      i = len - 1;
      while(i >= 0)
      {
         __y = _itemHeight * i;
         if(itemArr[i] is Effect)
         {
            itemArr[i].py = this.y + __y;
         }
         else
         {
            itemArr[i].y = this.y + __y;
            if(itemArr[y] is ILayout)
            {
               itemArr[y].align();
            }
         }
         i -= 1;
      }
   }
}
