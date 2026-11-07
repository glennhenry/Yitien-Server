package com.yiTian.view.modules.paihang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel2;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
   import com.yiTian.view.modules.yellowDiamond.Model_init;
   import com.yiTian.view.modules.zhuanZhi.View_ZhuanZhiAtbSp;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class HeroInfoPanel extends Panel2
   {
      
      public static const GRID_LEN:int = 11;
      
      private static const MAX_GRID:int = 12;
      
      private static var isFirstOpen:Boolean = true;
      
      private var bm:Bitmap;
      
      private var curTitle:Bitmap;
      
      private var nameTxt:MyTextField;
      
      private var levelTxt:MyTextField;
      
      private var menPaiTxt:MyTextField;
      
      private var CBvalue:MyTextField;
      
      private var BSvalue:MyTextField;
      
      private var CBButton:Button;
      
      private var BSButton:Button;
      
      private var zhanLi:MyTextField;
      
      private var arr_str:Array;
      
      private var _jobAtbIcon:View_ZhuanZhiAtbSp;
      
      private var arr_gridPosition:Array = [[256,145],[37,145],[37,241],[37,289],[37,97],[37,193],[256,193],[256,97],[256,241],[256,289],[37,337],[256,337]];
      
      private var vec_grids:Vector.<View_Grid>;
      
      private var zhiYeArr:Array;
      
      private var ack:DisplayObject;
      
      private var hlSP:ringSP;
      
      private var vecTitle:Vector.<String> = new <String>["Title_DengJi","Title_ZhanLi","Title_CaiFu","Title_JingJi","Title_RoleInf"];
      
      private var _id:int;
      
      private var _name:String;
      
      private var vec_Vo_equip_cache:Vector.<Vo_equip>;
      
      private var effVec:Vector.<Effect> = new Vector.<Effect>();
      
      public function HeroInfoPanel()
      {
         super();
      }
      
      public function get gridV() : Vector.<View_Grid>
      {
         return this.vec_grids;
      }
      
      override protected function initStaticView() : void
      {
         var bitmap:Bitmap = null;
         var grid:View_Grid = null;
         var i:int = 0;
         tmpParent = GameScene.sysLayer;
         this.zhiYeArr = [LangConfig.getWord("10036",1),LangConfig.getWord("10037",1),LangConfig.getWord("10038",1),LangConfig.getWord("10039",1)];
         this.arr_str = [LangConfig.getWord("10279",1),LangConfig.getWord("10280",1),LangConfig.getWord("10281",1),LangConfig.getWord("10282",1),LangConfig.getWord("10283",1),LangConfig.getWord("10284",1),LangConfig.getWord("10290",1),LangConfig.getWord("10286",1),LangConfig.getWord("10291",1),LangConfig.getWord("10292",1),LangConfig.getWord("10289",1),LangConfig.getWord("10288",1)];
         this.ack = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":327,
            "height":450
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":24,
            "y":38,
            "width":279,
            "height":405
         },Global.Img_Cdm);
         bitmap = new Bitmap();
         this.curTitle = new Bitmap();
         this.curTitle.y = 5;
         addChild(this.curTitle);
         move = new Rectangle(0,0,this.ack.width,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":294,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.bm = ComponentUtil.getBitmap("",this,{
            "x":45,
            "y":70
         });
         this.nameTxt = ComponentUtil.getTextField("",this,{
            "x":94 - 40,
            "y":47,
            "color":3644132,
            "size":16,
            "leading":0
         });
         this.nameTxt.realWidth = 224;
         this.nameTxt.size = 16;
         this.nameTxt.align = TextFormatAlign.CENTER;
         this.nameTxt.text = "";
         this.levelTxt = ComponentUtil.getTextField("",this,{
            "x":101,
            "y":72,
            "color":14662240,
            "size":12,
            "leading":0
         });
         var lt:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("10303",1),this,{
            "x":60,
            "y":72,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.menPaiTxt = ComponentUtil.getTextField("",this,{
            "x":216,
            "y":72,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60482",6),this,{
            "x":175,
            "y":72,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60483",6),this,{
            "x":41,
            "y":390,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60484",6),this,{
            "x":186,
            "y":390,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.CBvalue = ComponentUtil.getTextField("",this,{
            "x":111,
            "y":390,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.BSvalue = ComponentUtil.getTextField("",this,{
            "x":256,
            "y":390,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.CBButton = ComponentUtil.getButton(LangConfig.getWord("60485",6),"Button_Two64",this,{
            "x":63,
            "y":410,
            "textColor":16773818
         },Global.Img_Cdm);
         this.BSButton = ComponentUtil.getButton(LangConfig.getWord("60486",6),"Button_Two64",this,{
            "x":201,
            "y":410,
            "textColor":16773818
         },Global.Img_Cdm);
         addChild(bitmap);
         Utils.loadTitle("lang/ch/Rank_Imgs.swf","Back_Power",bitmap,{
            "x":95,
            "y":345
         });
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":40,
            "y":385,
            "width":250,
            "height":2
         },Global.Img_Cdm);
         this.zhanLi = ComponentUtil.getTextField("",this,{
            "x":115,
            "y":350,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.zhanLi.realWidth = 100;
         this.zhanLi.align = TextFormatAlign.CENTER;
         this.vec_grids = new Vector.<View_Grid>(GRID_LEN,true);
         i = 0;
         while(i < this.vec_grids.length)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.ROLE_EQUIP_OTHER;
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_info(this.arr_str[i]);
            grid.index = i + 1;
            grid.x = this.arr_gridPosition[i][0];
            grid.y = this.arr_gridPosition[i][1];
            addChild(grid);
            this.vec_grids[i] = grid;
            this.effVec.push(new Effect());
            i++;
         }
         this.hlSP = new ringSP();
         ComponentUtil.setPropertie(this.hlSP,{
            "x":200,
            "y":105
         });
         addChild(this.hlSP);
         this.CBButton.addEventListener(MouseEvent.CLICK,this.CBClick);
         this.BSButton.addEventListener(MouseEvent.CLICK,this.BSClick);
         this._jobAtbIcon = new View_ZhuanZhiAtbSp();
         this._jobAtbIcon.enableLoad();
         this._jobAtbIcon.x = 93;
         this._jobAtbIcon.y = 97;
         addChild(this._jobAtbIcon);
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
      
      public function updateStoneLvl(stoneLvl:int) : void
      {
         var i:int = 0;
         while(i < GRID_LEN)
         {
            this.vec_grids[i].stoneLvl = stoneLvl;
            i++;
         }
      }
      
      public function open() : void
      {
      }
      
      public function update() : void
      {
         switch(PaiHangVO.type)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60492",6));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60493",6));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60494",6));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60495",6));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60496",6));
               break;
            case 6:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60497",6));
         }
      }
      
      private function CBClick(e:MouseEvent) : void
      {
         RoleCGMessage.CG_BUTTON_CBBS(this._name,1);
      }
      
      private function BSClick(e:MouseEvent) : void
      {
         RoleCGMessage.CG_BUTTON_CBBS(this._name,2);
      }
      
      public function showRoleInfo(id:int, name:String, sex:int, level:int, zhiYe:int, equip:Array, diaoXiangType:int, ringId:int = 0, qinmiDu:int = 0, stoneLvl:int = 0) : void
      {
         this.visible = true;
         this._id = id;
         this._name = name;
         Utils.loadTitle("lang/ch/Rank_Imgs.swf",this.vecTitle[Boolean(diaoXiangType) ? diaoXiangType - diaoXiangType / 2 : diaoXiangType],this.curTitle,null,null,this.onCom);
         Utils.getLoadBitmap(Const_strImg.getPlayerHead(zhiYe,sex,5),this.bm);
         this.nameTxt.text = Model_heFu.repNameByHero(name);
         this.levelTxt.text = level.toString();
         this.vec_Vo_equip_cache = this.get_role_vec_equip(equip);
         this.Show();
         this.updateRing(ringId,qinmiDu);
         this.updateStoneLvl(stoneLvl);
         this._jobAtbIcon.setJob(zhiYe);
      }
      
      private function onCom() : void
      {
         this.curTitle.x = (this.ack.width - this.curTitle.width) / 2;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      private function Show() : void
      {
         var i:int = 0;
         while(i < this.vec_grids.length)
         {
            this.vec_grids[i].vo = this.vec_Vo_equip_cache[i];
            i++;
         }
         if(visible)
         {
            this.showGridEff();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            isFirstOpen = false;
            this.hlSP.isAutoLoad = true;
         }
         else if(!isFirstOpen)
         {
            this.removeGridEff();
         }
      }
      
      private function showGridEff() : void
      {
         if(Model_init.isChangeEff)
         {
            return;
         }
         this.removeGridEff();
         var i:int = 0;
         while(i < GRID_LEN)
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
      
      private function removeGridEff() : void
      {
         if(Model_init.isChangeEff)
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
      
      public function get vec_voEequip_cache() : Vector.<Vo_equip>
      {
         return this.vec_Vo_equip_cache;
      }
      
      public function getEuqipSingle(enum_pos:int) : Vo_equip
      {
         if(Boolean(this.vec_grids[enum_pos].vo))
         {
            return this.vec_grids[enum_pos].vo as Vo_equip;
         }
         return null;
      }
      
      private function get_role_vec_equip(equips:Array) : Vector.<Vo_equip>
      {
         var equip_t:Vo_equip = null;
         var vec_equip:Vector.<Vo_equip> = new Vector.<Vo_equip>(MAX_GRID,true);
         var i:int = 0;
         while(i < equips.length)
         {
            equip_t = new Vo_equip();
            equip_t.Init_sever_bag(equips[i]);
            equip_t.bDress = true;
            vec_equip[equip_t.gridId - 1] = equip_t;
            i++;
         }
         return vec_equip;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.ack.width) / 2;
         y = (Global.stage.stageHeight - this.ack.height) / 2;
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
