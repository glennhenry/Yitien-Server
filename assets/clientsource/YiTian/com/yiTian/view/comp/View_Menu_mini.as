package com.yiTian.view.comp
{
   import com.event.Button_h;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_wing;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FruitShopHandler;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.net.message.cg.ChunJieNianGaoCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.net.message.cg.TianmingJJCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.bianxinggaiming.View_BangHuiGaiMingPanel;
   import com.yiTian.view.modules.cast.baishiZengyi.View_baoshiZY;
   import com.yiTian.view.modules.cast.baishiZengyi.Vo_baoshiZY;
   import com.yiTian.view.modules.chat.View_ChatPanel;
   import com.yiTian.view.modules.guaji.Model_guajiInfo;
   import com.yiTian.view.modules.horse.HorseConfig;
   import com.yiTian.view.modules.horse.View_horsePanel;
   import com.yiTian.view.modules.huangbang.Model_Huangbang;
   import com.yiTian.view.modules.huangbang.View_HuangbangPanel;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import com.yiTian.view.modules.panel.View_layIn_pill;
   import com.yiTian.view.modules.panel.View_num_valuable;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_Menu_mini extends Sprite
   {
      
      private static var useType:int;
      
      public static const COUNT:int = 7;
      
      public static const USE_OR_DRESS:int = 0;
      
      public static const NUMSUSED:int = 1;
      
      public static const EQUIP_INTENSIFY:int = 2;
      
      public static const DISCARD:int = 3;
      
      public static const SHOW:int = 4;
      
      public static const RIDE:int = 5;
      
      public static const CZ_REFINE:int = 6;
      
      public static const CZ_STR:String = "橙装精炼";
      
      private var ARR_STR:Array = new Array();
      
      private var border:DisplayObject;
      
      private var vo:Vo_valuable;
      
      private var vec_btn:Vector.<Button_h>;
      
      private var back2:ScaleBitmap;
      
      private var grid:View_Grid;
      
      private var gap_height:int = 2;
      
      private var id_arr:Array = [46340,46341,46342];
      
      private var index_of_btn_arr:Array = new Array();
      
      public function View_Menu_mini()
      {
         var btn:Button_h = null;
         var i:int = 0;
         super();
         this.initStr();
         this.back2 = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":-1,
            "width":87,
            "height":95
         },Global.Img_Cdm);
         this.vec_btn = new Vector.<Button_h>(COUNT,true);
         i = 0;
         while(i < COUNT)
         {
            if(i == USE_OR_DRESS)
            {
               btn = ComponentUtil.getButton_h("xx","ChannelButtonFour",true,true,true,this,{"txtColor":14013822});
            }
            else
            {
               btn = ComponentUtil.getButton_h(this.ARR_STR[i],"ChannelButtonFour",false,true,true,this,{"txtColor":14013822});
            }
            btn.addEventListener(MouseEvent.CLICK,this.CLICK_BTN);
            btn.tabIndex = i;
            btn.x = 5;
            btn.y = 1;
            this.vec_btn[i] = btn;
            i++;
         }
         this.back2.width = this.vec_btn[0].width + 9;
      }
      
      private function initStr() : void
      {
         this.ARR_STR = ["xx","xx",LangConfig.getWord("736",0),LangConfig.getWord("737",0),LangConfig.getWord("261",0),LangConfig.getWord("738",0),CZ_STR];
         this.index_of_btn_arr = [LangConfig.getWord("268",0),LangConfig.getWord("189",0),LangConfig.getWord("739",0),LangConfig.getWord("740",0),LangConfig.getWord("736",0),LangConfig.getWord("738",0)];
      }
      
      private function re_set() : void
      {
         var i:int = 0;
         while(i < this.vec_btn.length)
         {
            this.vec_btn[i].visible = false;
            i++;
         }
      }
      
      public function show($vo:Vo_valuable, _grid:View_Grid) : void
      {
         var vo_item:Vo_item = null;
         var vo_equip:Vo_equip = null;
         var vo_equipR:Vo_equip = null;
         visible = true;
         if(this.vo == $vo)
         {
            return;
         }
         this.vo = $vo;
         this.grid = _grid;
         this.re_set();
         if(this.vo is Vo_item)
         {
            vo_item = this.vo as Vo_item;
            if(vo_item.bUseable == 1 || vo_item.bUseable == 2)
            {
               this.vec_btn[USE_OR_DRESS].set_htmlText(LangConfig.getWord("739",0));
               this.vec_btn[USE_OR_DRESS].visible = true;
               if(vo_item.bUseable == 1)
               {
                  useType = 1;
                  this.vec_btn[NUMSUSED].set_htmlText(LangConfig.getWord("738",0));
                  this.vec_btn[NUMSUSED].visible = true;
               }
               else if(vo_item.bUseable == 2)
               {
                  useType = 2;
               }
               if(vo_item.num_combining != 0)
               {
                  this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("268",0));
                  this.vec_btn[EQUIP_INTENSIFY].visible = true;
                  if(vo_item.type == 180)
                  {
                     this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("189",0));
                     this.vec_btn[DISCARD].visible = true;
                     this.vec_btn[SHOW].set_htmlText(LangConfig.getWord("740",0));
                     this.vec_btn[SHOW].visible = true;
                     if(vo_item.bDiscard)
                     {
                        this.vec_btn[RIDE].set_htmlText(LangConfig.getWord("736",0));
                        this.vec_btn[RIDE].visible = true;
                     }
                  }
                  else
                  {
                     this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("740",0));
                     this.vec_btn[DISCARD].visible = true;
                     if(vo_item.bDiscard)
                     {
                        this.vec_btn[RIDE].set_htmlText(LangConfig.getWord("736",0));
                        this.vec_btn[RIDE].visible = true;
                     }
                  }
               }
               else if(vo_item.num_combining != 0)
               {
                  this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("268",0));
                  this.vec_btn[EQUIP_INTENSIFY].visible = true;
                  this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("740",0));
                  this.vec_btn[DISCARD].visible = true;
                  if(vo_item.bDiscard)
                  {
                     this.vec_btn[SHOW].set_htmlText(LangConfig.getWord("736",0));
                     this.vec_btn[SHOW].visible = true;
                  }
               }
               else
               {
                  this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("740",0));
                  this.vec_btn[EQUIP_INTENSIFY].visible = true;
                  if(vo_item.bDiscard)
                  {
                     this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("736",0));
                     this.vec_btn[DISCARD].visible = true;
                  }
               }
            }
            else if(vo_item.num_combining != 0)
            {
               this.vec_btn[USE_OR_DRESS].set_htmlText(LangConfig.getWord("268",0));
               this.vec_btn[USE_OR_DRESS].visible = true;
               if(vo_item.type == 180)
               {
                  this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("189",0));
                  this.vec_btn[EQUIP_INTENSIFY].visible = true;
                  this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("740",0));
                  this.vec_btn[DISCARD].visible = true;
                  if(vo_item.bDiscard)
                  {
                     this.vec_btn[SHOW].set_htmlText(LangConfig.getWord("736",0));
                     this.vec_btn[SHOW].visible = true;
                  }
               }
               else
               {
                  this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("740",0));
                  this.vec_btn[EQUIP_INTENSIFY].visible = true;
                  if(vo_item.bDiscard)
                  {
                     this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("736",0));
                     this.vec_btn[DISCARD].visible = true;
                  }
               }
            }
            else if(vo_item.type == 180)
            {
               this.vec_btn[USE_OR_DRESS].set_htmlText(LangConfig.getWord("189",0));
               this.vec_btn[USE_OR_DRESS].visible = true;
               this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("740",0));
               this.vec_btn[EQUIP_INTENSIFY].visible = true;
               if(vo_item.bDiscard)
               {
                  this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("736",0));
                  this.vec_btn[DISCARD].visible = true;
               }
            }
            else
            {
               this.vec_btn[USE_OR_DRESS].set_htmlText(LangConfig.getWord("740",0));
               this.vec_btn[USE_OR_DRESS].visible = true;
               if(vo_item.bDiscard)
               {
                  this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("736",0));
                  this.vec_btn[EQUIP_INTENSIFY].visible = true;
               }
            }
         }
         else if(this.vo is Vo_equip && this.vo.type != 10)
         {
            vo_equip = this.vo as Vo_equip;
            if(GameUnitManager.hero.level < vo_equip.lv_use)
            {
               this.vec_btn[USE_OR_DRESS].visible = false;
            }
            else if(GameUnitManager.hero.job != vo_equip.job && vo_equip.job != Enum_job.ALL)
            {
               this.vec_btn[USE_OR_DRESS].visible = false;
            }
            this.vec_btn[USE_OR_DRESS].set_htmlText(LangConfig.getWord("741",0));
            this.vec_btn[USE_OR_DRESS].visible = true;
            if(vo_equip.type != 12)
            {
               this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("742",0));
               this.vec_btn[EQUIP_INTENSIFY].visible = true;
               this.vec_btn[DISCARD].visible = true;
               this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("155",0));
            }
            if(vo_equip.color == 5 || vo_equip.color == 4 && vo_equip.lv_use >= 50)
            {
               this.vec_btn[SHOW].visible = true;
               this.vec_btn[SHOW].set_htmlText(LangConfig.getWord("941",0));
               this.vec_btn[RIDE].visible = true;
               this.vec_btn[RIDE].set_htmlText(LangConfig.getWord("744",0));
               this.vec_btn[CZ_REFINE].visible = true;
               this.vec_btn[CZ_REFINE].set_htmlText(LangConfig.getWord("745",0));
            }
            else
            {
               this.vec_btn[SHOW].visible = true;
               this.vec_btn[SHOW].set_htmlText(LangConfig.getWord("744",0));
               this.vec_btn[RIDE].visible = true;
               this.vec_btn[RIDE].set_htmlText(LangConfig.getWord("745",0));
            }
         }
         else if(this.vo is Vo_equip && this.vo.type == 10)
         {
            vo_equipR = this.vo as Vo_equip;
            if(GameUnitManager.hero.level < vo_equipR.lv_use)
            {
               this.vec_btn[USE_OR_DRESS].visible = false;
            }
            else if(GameUnitManager.hero.job != vo_equipR.job && vo_equipR.job != Enum_job.ALL)
            {
               this.vec_btn[USE_OR_DRESS].visible = false;
            }
            this.vec_btn[USE_OR_DRESS].set_htmlText(LangConfig.getWord("746",0));
            this.vec_btn[USE_OR_DRESS].visible = true;
            this.vec_btn[EQUIP_INTENSIFY].set_htmlText(LangConfig.getWord("747",0));
            this.vec_btn[EQUIP_INTENSIFY].visible = true;
            this.vec_btn[DISCARD].visible = true;
            this.vec_btn[DISCARD].set_htmlText(LangConfig.getWord("261",0));
            this.vec_btn[SHOW].visible = true;
            this.vec_btn[SHOW].set_htmlText(LangConfig.getWord("748",0));
            this.vec_btn[RIDE].visible = true;
            this.vec_btn[RIDE].set_htmlText(LangConfig.getWord("745",0));
         }
         this.set_pos();
      }
      
      private function set_pos() : void
      {
         var count:int = 0;
         var i:int = 0;
         while(i < this.vec_btn.length)
         {
            if(this.vec_btn[i].visible)
            {
               this.vec_btn[i].y = count * this.vec_btn[0].height + (count + 1) * this.gap_height;
               count++;
            }
            i++;
         }
         this.back2.height = this.vec_btn[0].y + count * this.vec_btn[0].height + count * this.gap_height + 2;
      }
      
      private function OK_USE() : void
      {
         BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,this.vo.gridId,1);
      }
      
      private function OK_DISCARD() : void
      {
         BagCGMessage.CG_BAG_REDUCE(BagCGMessage.DISCARD,this.vo.gridId,0);
      }
      
      private function getOldVip() : Vo_item
      {
         var voI:Vo_item = new Vo_item();
         voI.id = this.id_arr[GameUnitManager.hero.vip - 1];
         voI.Init_lib();
         return voI;
      }
      
      private function getColor(item:Vo_item) : String
      {
         var str:String = item.str_name;
         if(item.lv == 1)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.GREEN));
         }
         else if(item.lv == 2)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.BLUE));
         }
         else if(item.lv == 3)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.PURPLE));
         }
         return str;
      }
      
      private function handle_of_use(vo:Vo_valuable, btn:Button_h) : void
      {
         var pan:View_baoshiZY = null;
         var horsePnl:View_horsePanel = null;
         var oldItem:Vo_item = null;
         if(Global.pf == "qqgame")
         {
            if(vo.id == 46415)
            {
               UIManager.centerBroadcast.addMsg("麒麟卡只能在黄钻区域才能使用");
               return;
            }
         }
         else if(vo.id == 46463)
         {
            UIManager.centerBroadcast.addMsg("布鲁卡只能在蓝钻区域才能使用");
            return;
         }
         if(vo.id == 46496)
         {
            UIManager.bianXingGaiMing.bianXingHandler(vo);
            return;
         }
         if(vo.id == 44477)
         {
            pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
            {
               pan.updata(Vo_baoshiZY.StoneLvl);
            });
            return;
         }
         if(vo.id == 46495)
         {
            UIManager.bianXingGaiMing.gaiMing(vo);
            return;
         }
         if(vo.id >= 46615 && vo.id <= 46618)
         {
            Model_guajiInfo.getInstance().useGjdItem(vo as Vo_item);
            return;
         }
         if(vo.id == HorseConfig.FORGESTONE_ID)
         {
            horsePnl = Singleton.getInstance(View_horsePanel);
            Global.delegate.dosomething(horsePnl,horsePnl.show);
            return;
         }
         if(vo.id == HorseConfig.QIANGHUASTONE_ID)
         {
            horsePnl = Singleton.getInstance(View_horsePanel);
            Global.delegate.dosomething(horsePnl,function():void
            {
               horsePnl.show(2);
            });
            return;
         }
         if(vo.id == ShenBingUtil.YUPAI_ID || vo.id == ShenBingUtil.SHENBING_CHIP_ID)
         {
            ShenBingUtil.askOpenShenBingPanel();
            return;
         }
         if(vo.id == 46587)
         {
            (Singleton.getInstance(View_BangHuiGaiMingPanel) as View_BangHuiGaiMingPanel).show(vo as Vo_valuable);
         }
         if(vo.id == 46620 || vo.id == 46621 || vo.id == 46622 || vo.id == 46623 || vo.id == 46624 || vo.id == 46625 || vo.id == 46626 || vo.id == 46627)
         {
            if(!UIManager.layInPill)
            {
               UIManager.layInPill = new View_layIn_pill();
               UIManager.layInPill.init();
            }
            UIManager.layInPill.visible = true;
            UIManager.layInPill.update(vo.id,1,vo.str_name,vo.color,vo.gridId);
            return;
         }
         if(Data_lib.item[vo.id][Enum_lib_item.TYPE] == Enum_item_type.PET_SKILL_BOOK)
         {
            UIManager.petPanel.petSkillBook(vo);
         }
         else if(Data_lib.item[vo.id][Enum_lib_item.TYPE] == Enum_item_type.VIP)
         {
            oldItem = this.getOldVip();
            if(GameUnitManager.hero.vip > 0)
            {
               if(vo.id == this.id_arr[GameUnitManager.hero.vip - 1])
               {
                  BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
               }
               else
               {
                  View_Alert.show(LangConfig.getWord("10366",1,this.getColor(vo as Vo_item),this.getColor(oldItem)),View_Alert.OK_CANCAL,this.OK_USE);
               }
            }
            else
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
            }
         }
         else if(Data_lib.item[vo.id][Enum_lib_item.TYPE] == Enum_item_type.FISH)
         {
            if(btn.enabled)
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("750",0));
            }
         }
         else if(Data_lib.item[vo.id][Enum_lib_item.TYPE] == Enum_item_type.PET_CHANGE_CARD)
         {
            UIManager.petPanel.petChangeCard(vo);
         }
         else if(vo.type == 420)
         {
            if(Model_wing.HuanHuaDanID > 0 && vo.id != Data_lib.wingChange[Model_wing.HuanHuaDanID][0])
            {
               View_Alert.show("你确定要用" + HtmlUtil.font(vo.str_name,ColorConstant.getItemColorStr((vo as Vo_valuable).color)) + "覆盖" + HtmlUtil.font(Data_lib.item[Data_lib.wingChange[Model_wing.HuanHuaDanID][0]][1],ColorConstant.getItemColorStr(Data_lib.item[Data_lib.wingChange[Model_wing.HuanHuaDanID][0]][12])) + "吗？",2,function():void
               {
                  BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
               },null,null,null,340);
            }
            else
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
            }
         }
         else if(vo.count > 1)
         {
            if(vo.type == 200)
            {
               UIManager.heroHead.buffItemUse(vo as Vo_item,1);
               return;
            }
            if(vo.id == 45384)
            {
               ChunJieNianGaoCGMessage.CG_ChunJieNianGao_EAT(1,vo.gridId);
               return;
            }
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
         }
         else
         {
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
         }
      }
      
      private function handleIndex(_index:int, vo:Vo_valuable, btn:Button_h) : void
      {
         switch(_index)
         {
            case 1:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(5);
                  break;
               }
               UIManager.castPanel.openView(5);
               break;
            case 2:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(6);
                  break;
               }
               UIManager.castPanel.openView(6);
               break;
            case 3:
               if(useType == 1)
               {
                  this.handle_of_use(vo,btn);
                  break;
               }
               if(useType == 2)
               {
                  Model_bag.handleOf(vo as Vo_item);
               }
               break;
            case 4:
               View_ChatPanel.show("【" + vo.str_name + "】",vo);
               break;
            case 5:
               if(vo.bDiscard)
               {
                  View_Alert.show(LangConfig.getWord("751",0) + HtmlUtil.font(vo.str_name,ColorConstant.getColorStr(ColorConstant.RED)) + LangConfig.getWord("752",0),View_Alert.OK_CANCAL,this.OK_DISCARD);
                  break;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("753",0));
               break;
            case 6:
               if(Data_lib.item[this.grid.vo.id][Enum_lib_item.TYPE] == Enum_item_type.FISH)
               {
                  if(!GameUnitManager.hero.partyId && Model_bang.partyType == 0)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("750",0));
                     return;
                  }
               }
               UIManager.num_valuable.Show(vo,View_num_valuable.BAG_USE_ITEM);
         }
      }
      
      private function CLICK_BTN(e:MouseEvent) : void
      {
         var btn:Button_h = null;
         var temNum:int = 0;
         var matArr:Array = null;
         var num1:int = 0;
         var num2:int = 0;
         var num3:int = 0;
         var temStrArr:Array = null;
         var temY:int = 0;
         var temM:int = 0;
         var temD:int = 0;
         var temH:int = 0;
         var temMi:int = 0;
         var temS:int = 0;
         var temDate:Date = null;
         var a:uint = 0;
         var dateNum:int = 0;
         var pan:View_baoshiZY = null;
         btn = e.target as Button_h;
         visible = false;
         if(btn.tabIndex == USE_OR_DRESS)
         {
            if(this.vo is Vo_equip)
            {
               if(Enum_job.getBaseJob(GameUnitManager.hero.job) != this.vo.job && this.vo.job != Enum_job.ALL)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("871",0));
                  return;
               }
               if((this.vo as Vo_equip).type == 11)
               {
                  if(GameUnitManager.hero.sex != (this.vo as Vo_equip).sex)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("984",0));
                  }
               }
               RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.BAG_ROLE,this.vo.gridId);
            }
            else if(this.vo is Vo_item)
            {
               if(this.vo.id == Model_TianmingJJ.TOOLID)
               {
                  TianmingJJCGMessage.CG_TMJJ_OPENWIN();
                  return;
               }
               matArr = Data_lib.fruitShop[1][2].split(",");
               num1 = int(matArr[0].split("_")[0]);
               num2 = int(matArr[1].split("_")[0]);
               num3 = int(matArr[2].split("_")[0]);
               if(this.vo.id == num1 || this.vo.id == num2 || this.vo.id == num3)
               {
                  temStrArr = Data_lib.item[this.vo.id][Enum_lib_item.USEABLE_DATE].split("_");
                  temY = int(temStrArr[0].split("-")[0]);
                  temM = int(temStrArr[0].split("-")[1]);
                  temD = int(temStrArr[0].split("-")[2]);
                  temH = int(temStrArr[1].split(":")[0]);
                  temMi = int(temStrArr[1].split(":")[1]);
                  temS = int(temStrArr[1].split(":")[2]);
                  temDate = new Date(temY,temM - 1,temD,temH,temMi,temS);
                  a = FruitShopHandler.dateNum;
                  dateNum = uint(temDate.time / 1000) - a;
                  if(dateNum <= 0)
                  {
                     UIManager.centerBroadcast.addMsg("水果过期了");
                     return;
                  }
                  UIManager.fruitShop.visible = true;
                  return;
               }
               if(Model_Huangbang.jumpIdArr.indexOf(this.vo.id) != -1)
               {
                  if(Model_Huangbang.jumpIdArr.indexOf(this.vo.id) < Model_Huangbang.currentLoop)
                  {
                     UIManager.centerBroadcast.addMsg("当前跳跃令不能进行下一圈跳跃");
                     return;
                  }
                  if(SceneConfig.getSceneType() != SceneConfig.HUANGBANG)
                  {
                     UIManager.centerBroadcast.addMsg("只能在皇榜地图使用该道具");
                     return;
                  }
                  View_HuangbangPanel.instance.jump();
                  return;
               }
               temNum = this.index_of_btn_arr.indexOf(btn.btnLabel);
               this.handleIndex(temNum + 1,this.vo,btn);
            }
         }
         else if(btn.tabIndex == EQUIP_INTENSIFY)
         {
            if(this.vo is Vo_equip)
            {
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(Enum_panel_cast.EQUIP_INTENSIFY);
               }
               else
               {
                  UIManager.castPanel.openView(Enum_panel_cast.EQUIP_INTENSIFY);
               }
               UIManager.castPanel.get_child_cast_panel(Enum_panel_cast.EQUIP_INTENSIFY).setClickType(1);
               UIManager.castPanel.get_child_cast_panel(Enum_panel_cast.EQUIP_INTENSIFY).getClickVo(this.vo);
            }
            else if(this.vo is Vo_item)
            {
               temNum = this.index_of_btn_arr.indexOf(btn.btnLabel);
               this.handleIndex(temNum + 1,this.vo,btn);
            }
         }
         else if(btn.tabIndex == DISCARD)
         {
            if(this.vo is Vo_equip)
            {
               if(this.vo.color >= Model_bag.colorArr[3] && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
               {
                  Model_bag.isCastDiscard = 0;
                  UIManager.bagPwdPutIn.visible = true;
                  return;
               }
               Model_bag.isCastDiscard = 1;
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  if(this.vo.type != 10)
                  {
                     UIManager.castPanel.openView(Enum_panel_cast.EQUIP_DECOMPOSE);
                  }
               }
               else if(this.vo.type != 10)
               {
                  UIManager.castPanel.openView(Enum_panel_cast.EQUIP_DECOMPOSE);
               }
            }
            else if(this.vo is Vo_item)
            {
               temNum = this.index_of_btn_arr.indexOf(btn.btnLabel);
               this.handleIndex(temNum + 1,this.vo,btn);
            }
         }
         else if(btn.tabIndex == SHOW)
         {
            if(this.vo is Vo_equip)
            {
               if(this.vo.color == 5 || this.vo.lv_use >= 50 && this.vo.color == 4)
               {
                  if(!UIManager.castPanel.visible)
                  {
                     UIManager.castPanel.visible = true;
                     UIManager.castPanel.openView(Enum_panel_cast.EQUIP_CZ_JINGLIAN);
                  }
                  else
                  {
                     UIManager.castPanel.openView(Enum_panel_cast.EQUIP_CZ_JINGLIAN);
                  }
                  UIManager.castPanel.get_child_cast_panel(Enum_panel_cast.EQUIP_CZ_JINGLIAN).setClickType(1);
                  UIManager.castPanel.get_child_cast_panel(Enum_panel_cast.EQUIP_CZ_JINGLIAN).getClickVo(this.vo);
               }
               else
               {
                  View_ChatPanel.show("【" + this.vo.str_name + "】",this.vo);
               }
            }
            else if(this.vo is Vo_item)
            {
               temNum = this.index_of_btn_arr.indexOf(btn.btnLabel);
               this.handleIndex(temNum + 1,this.vo,btn);
            }
         }
         else if(btn.tabIndex == RIDE)
         {
            if(this.vo is Vo_equip && this.vo.color == 5 || this.vo is Vo_equip && this.vo.color == 4 && this.vo.lv_use >= 50)
            {
               View_ChatPanel.show("【" + this.vo.str_name + "】",this.vo);
            }
            else
            {
               if(this.vo is Vo_equip && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
               {
                  UIManager.bagPwdPutIn.visible = true;
                  return;
               }
               if(this.vo.bDiscard)
               {
                  View_Alert.show(LangConfig.getWord("751",0) + HtmlUtil.font(this.vo.str_name,ColorConstant.getColorStr(ColorConstant.RED)) + LangConfig.getWord("752",0),View_Alert.OK_CANCAL,this.OK_DISCARD);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("753",0));
               }
            }
         }
         else if(btn.tabIndex == NUMSUSED)
         {
            temNum = this.index_of_btn_arr.indexOf(btn.btnLabel);
            if(this.vo.id == 44477)
            {
               pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
               {
                  pan.updata(Vo_baoshiZY.StoneLvl);
               });
               return;
            }
            this.handleIndex(temNum + 1,this.vo,btn);
         }
         else if(btn.tabIndex == CZ_REFINE)
         {
            if(this.vo.bDiscard)
            {
               View_Alert.show(LangConfig.getWord("751",0) + HtmlUtil.font(this.vo.str_name,ColorConstant.getColorStr(ColorConstant.RED)) + LangConfig.getWord("752",0),View_Alert.OK_CANCAL,this.OK_DISCARD);
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("753",0));
            }
         }
      }
   }
}

