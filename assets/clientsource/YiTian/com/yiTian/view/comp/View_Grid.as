package com.yiTian.view.comp
{
   import com.event.TextField_h;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.yellowDiamond.Model_init;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class View_Grid extends Sprite
   {
      
      private static const EXCURSION_MAINMENU:int = 2;
      
      private static const EXCURSION_34:int = 3;
      
      private static const NUM_LAYER:int = 8;
      
      private static const OVER:int = 0;
      
      private static const BG:int = 1;
      
      private static const INFO:int = 2;
      
      private static const ICON_BG:int = 3;
      
      private static const ICON:int = 4;
      
      private static const SELECT:int = 5;
      
      private static const COUNT:int = 6;
      
      private static const MASK:int = 7;
      
      public static const GRID_MAINMENU:String = "resource/image/iconBg/grid.png";
      
      public static const GRID_OPEN:String = "resource/image/iconBg/open.png";
      
      public static const GRID_LOCK:String = "resource/image/iconBg/lock.png";
      
      public static const GRID_BAG_LOCK:String = "resource/image/iconBg/bagLock.png";
      
      public static const GRID_WENZI:String = "resource/image/iconBg/wenzi.png";
      
      public static const GRID_OVER:String = "resource/image/iconBg/over.png";
      
      public static const GRID_MASK:String = "resource/image/iconBg/mask.png";
      
      public static const GRID_SELECT:String = "resource/image/iconBg/select.png";
      
      public static const GRID_OVER_SKILL:String = "resource/image/iconBg/grid_Skill_over.png";
      
      public static const GRID_OPEN_SKILL:String = "resource/image/iconBg/grid_Skill_open.png";
      
      public static const GRID_SELECT_SKILL:String = "resource/image/iconBg/grid_Skill_Choose.png";
      
      public static const GRID_OVER_SKILL_SHENGONG:String = "resource/image/iconBg/grid_Magic_over.png";
      
      public static const GRID_OPEN_SKILL_SHENGONG:String = "resource/image/iconBg/grid_Magic_open.png";
      
      public static const GRID_SELECT_SKILL_SHENGONG:String = "resource/image/iconBg/grid_Magic_Choose.png";
      
      public static const GRID_BIGGEST_OPEN:String = "resource/image/iconBg/grid_ShangCheng_open.png";
      
      public static const GRID_BIGGEST_OVER:String = "resource/image/iconBg/grid_ShangCheng_over.png";
      
      public static const GRID_BIGGEST_DOWN:String = "resource/image/iconBg/grid_ShangCheng_down.png";
      
      public static const GRID_UNKNOW_SKILL:String = "resource/image/iconBg/Unknow_Skill.png";
      
      public static const GRID_TIANMING:String = "resource/image/iconBg/Icon_Round.png";
      
      public static const GRID_TIANMING_LOCK:String = "resource/image/iconBg/Icon_RoundLock.png";
      
      public static const GRID_TIANMING_OVER:String = "resource/image/iconBg/Icon_Roundover.png";
      
      public static const GRID_SHENBING:String = "resource/image/iconBg/Icon_SbRound.png";
      
      public static const GRID_SHENBING_LOCK:String = "resource/image/iconBg/Icon_SbRoundLock.png";
      
      public static const GRID_SHENBING_OVER:String = "resource/image/iconBg/Icon_SbRoundOver.png";
      
      public var index:int;
      
      public var type:int;
      
      private var vec:Vector.<DisplayObject>;
      
      private var bZero:Boolean;
      
      private var bOne:Boolean;
      
      private var _str_extend_name:String;
      
      private var _bBigIcon:Boolean;
      
      private var _bSelect:Boolean;
      
      private var _bMask:Boolean;
      
      private var _count:int;
      
      private var _vo:Vo_grid;
      
      private var bmp_bg:Bitmap2;
      
      private var tf_info:TextField_h;
      
      private var bmp_over:Bitmap;
      
      private var bmp_select:Bitmap;
      
      private var tf_count:TextField_h;
      
      private var bmp_mask:Bitmap;
      
      public var bmp_icon:Bitmap;
      
      private var bmp_iconBg:Bitmap;
      
      private var _lock:Boolean;
      
      public var stoneLvl:int;
      
      private var bigGroundBit:Boolean = false;
      
      private var isShowTf:Boolean = false;
      
      private var _gridId:int;
      
      private var isBold:Boolean = false;
      
      private var _isAutoLoad:Boolean = true;
      
      private var loadEff:Effect;
      
      private var eff175:Effect;
      
      private var eff176:Effect;
      
      private var eff177:Effect;
      
      public function View_Grid($bBigIcon:Boolean = false, str_extend_name:String = ".png")
      {
         super();
         this._bBigIcon = $bBigIcon;
         this._str_extend_name = str_extend_name;
         mouseChildren = false;
         this.vec = new Vector.<DisplayObject>(NUM_LAYER,true);
         this.bmp_iconBg = new Bitmap();
         this.AddChild(this.bmp_iconBg,ICON_BG);
         this.bmp_icon = new Bitmap();
         this.AddChild(this.bmp_icon,ICON);
      }
      
      public function set bmpBacKShow(value:Boolean) : void
      {
         if(Boolean(this.bmp_bg))
         {
            this.bmp_bg.visible = value;
         }
         if(Boolean(this.bmp_iconBg))
         {
            this.bmp_iconBg.visible = value;
         }
      }
      
      public function set_bmp_bg(str:String = "resource/image/iconBg/open.png") : void
      {
         if(str == GRID_BIGGEST_OPEN)
         {
            this.bigGroundBit = true;
         }
         if(str == GRID_OPEN)
         {
            this.lock = false;
         }
         else if(str == GRID_LOCK)
         {
            this.lock = true;
         }
         if(Boolean(str))
         {
            if(this.bmp_bg == null)
            {
               this.bmp_bg = new Bitmap2();
               this.AddChild(this.bmp_bg,BG);
            }
            this.bmp_bg.load(str);
            if(str == GRID_MAINMENU)
            {
               this.bmp_bg.x = -EXCURSION_MAINMENU;
               this.bmp_bg.y = -EXCURSION_MAINMENU;
            }
            else
            {
               this.bmp_bg.x = -EXCURSION_34;
               this.bmp_bg.y = -EXCURSION_34;
            }
         }
         else if(Boolean(this.bmp_bg))
         {
            this.bmp_bg.load(null);
         }
      }
      
      public function set_tf_info(str:String, _numChild:int = 2, value:Boolean = false) : void
      {
         var textFormat:TextFormat = null;
         this.isShowTf = value;
         if(Boolean(str))
         {
            if(this.tf_info == null)
            {
               this.tf_info = new TextField_h();
               addChildAt(this.tf_info,_numChild);
               textFormat = new TextFormat();
               textFormat.align = TextFormatAlign.CENTER;
               this.tf_info.defaultTextFormat = textFormat;
            }
            this.tf_info.htmlText = str;
            this.tf_info.visible = true;
            this.tf_info.x = (Const_png.SIZE_ICON - this.tf_info.width) / 2;
            if(_numChild != INFO)
            {
               this.tf_info.y = (Const_png.SIZE_ICON - this.tf_info.height) / 2;
               this.tf_info.x = (Const_png.SIZE_ICON - this.tf_info.width) / 2;
            }
            else
            {
               this.tf_info.y = (Const_png.SIZE_ICON - this.tf_info.height) / 2;
            }
            if(value)
            {
               this.tf_info.x = (Const_png.SIZE_ICON - this.tf_info.width) / 2 + 3;
               this.tf_info.y = (Const_png.SIZE_ICON - this.tf_info.height) / 2 + 3;
            }
            setChildIndex(this.tf_info,_numChild);
         }
         else if(Boolean(this.tf_info))
         {
            this.tf_info.text = "";
         }
      }
      
      public function set lock(value:Boolean) : void
      {
         this._lock = value;
      }
      
      public function get lock() : Boolean
      {
         return this._lock;
      }
      
      public function set_bmp_over(bListen:Boolean = true, str:String = "resource/image/iconBg/over.png") : void
      {
         if(bListen)
         {
            if(Boolean(str))
            {
               if(this.bmp_over == null)
               {
                  this.bmp_over = new Bitmap();
                  this.AddChild(this.bmp_over,OVER);
               }
               Utils.getLoadBitmap(str,this.bmp_over);
               this.bmp_over.visible = false;
               if(str == View_Grid.GRID_TIANMING_OVER)
               {
                  this.bmp_over.x = -EXCURSION_34 - 2;
                  this.bmp_over.y = -EXCURSION_34 - 2;
               }
               else
               {
                  this.bmp_over.x = -EXCURSION_34;
                  this.bmp_over.y = -EXCURSION_34;
               }
            }
            else if(Boolean(this.bmp_over))
            {
               this.bmp_over.bitmapData = null;
            }
            if(hasEventListener(MouseEvent.ROLL_OVER) == false)
            {
               addEventListener(MouseEvent.ROLL_OVER,this.ROLL_OVER);
            }
            if(hasEventListener(MouseEvent.ROLL_OUT) == false)
            {
               addEventListener(MouseEvent.ROLL_OUT,this.ROLL_OUT);
            }
         }
         else
         {
            if(Boolean(this.bmp_over))
            {
               this.bmp_over.bitmapData = null;
            }
            removeEventListener(MouseEvent.ROLL_OVER,this.ROLL_OVER);
            removeEventListener(MouseEvent.ROLL_OUT,this.ROLL_OUT);
         }
      }
      
      public function set_bmp_select(str:String = "resource/image/iconBg/select.png") : void
      {
         if(Boolean(str))
         {
            if(this.bmp_select == null)
            {
               this.bmp_select = new Bitmap();
               this.AddChild(this.bmp_select,SELECT);
            }
            Utils.getLoadBitmap(str,this.bmp_select);
            this.bmp_select.visible = false;
            this.bmp_select.x = -EXCURSION_34;
            this.bmp_select.y = -EXCURSION_34;
         }
         else if(Boolean(this.bmp_select))
         {
            this.bmp_select.bitmapData = null;
         }
      }
      
      public function set gridId(value:int) : void
      {
         this._gridId = value;
      }
      
      public function get gridId() : int
      {
         return this._gridId;
      }
      
      public function get bSelect() : Boolean
      {
         return this._bSelect;
      }
      
      public function set bSelect(value:Boolean) : void
      {
         this._bSelect = value;
         if(Boolean(this.bmp_select))
         {
            this.bmp_select.visible = value;
         }
      }
      
      public function set_tf_count($bShow:Boolean = true, $bZero:Boolean = false, $bOne:Boolean = false) : void
      {
         if($bShow)
         {
            if(this.tf_count == null)
            {
               this.tf_count = new TextField_h();
               this.AddChild(this.tf_count,COUNT);
               this.tf_count.y = Const_png.SIZE_ICON - 18;
            }
            else
            {
               this.AddChild(this.tf_count,COUNT);
            }
         }
         else if(Boolean(this.tf_count))
         {
            this.tf_count.text = "";
         }
         this.bZero = $bZero;
         this.bOne = $bOne;
         if(this.bigGroundBit)
         {
            this.tf_count.y = 64 - 15;
         }
      }
      
      public function set count(value:int) : void
      {
         this._count = value;
         if(this._vo == null || this.tf_count == null)
         {
            return;
         }
         if(value == 0)
         {
            if(this.bZero == false)
            {
               this.tf_count.visible = false;
               return;
            }
         }
         else if(value == 1)
         {
            if(this.bOne == false)
            {
               this.tf_count.visible = false;
               return;
            }
         }
         var iconSize:int = this._bBigIcon ? Const_png.SIZE_BIG_ICON : Const_png.SIZE_ICON;
         if(this.isBold)
         {
            this.tf_count.htmlText = HtmlUtil.font(HtmlUtil.bold(value.toString()),"#ff7700");
            this.tf_count.x = this.bmp_icon.x + iconSize - this.tf_count.width + 5;
            this.tf_count.y = iconSize - 13;
            this.tf_count.visible = true;
         }
         else
         {
            this.tf_count.text = value.toString();
            this.tf_count.x = this.bmp_icon.x + iconSize - this.tf_count.width;
            this.tf_count.y = iconSize - 18;
            this.tf_count.visible = true;
            if(value.toString().length == 1 && this.tf_count.x != 23 && !this._bBigIcon)
            {
               this.tf_count.x = 23;
            }
            if(value.toString().length == 2 && this.tf_count.x != 16 && !this._bBigIcon)
            {
               this.tf_count.x = 16;
            }
            if(this.bigGroundBit)
            {
               this.tf_count.x = 64 - 15;
            }
         }
      }
      
      public function setTFstyle(value:Boolean = false) : void
      {
         this.isBold = value;
      }
      
      public function get count() : int
      {
         return this._count;
      }
      
      public function set_grey(bShow:Boolean) : void
      {
         filters = bShow ? Util.disabled : null;
      }
      
      public function set_bmp_mask(str:String = "resource/image/iconBg/mask.png") : void
      {
         if(Boolean(str))
         {
            if(this.bmp_mask == null)
            {
               this.bmp_mask = new Bitmap();
               this.AddChild(this.bmp_mask,MASK);
            }
            Utils.getLoadBitmap(str,this.bmp_mask);
            this.bmp_mask.visible = false;
            this.bmp_mask.x = -EXCURSION_34;
            this.bmp_mask.y = -EXCURSION_34;
         }
         else if(Boolean(this.bmp_mask))
         {
            this.bmp_mask.bitmapData = null;
         }
      }
      
      public function set bMask(value:Boolean) : void
      {
         this.bmp_mask.visible = value;
         mouseEnabled = !value;
      }
      
      public function get bMask() : Boolean
      {
         return this._bMask;
      }
      
      public function get_iconBg_Bitmapdata() : BitmapData
      {
         return this.bmp_iconBg.bitmapData;
      }
      
      public function get_icon_BitmapData() : BitmapData
      {
         return this.bmp_icon.bitmapData;
      }
      
      public function set vo($vo:Vo_grid) : void
      {
         this._vo = $vo;
         if(this._isAutoLoad)
         {
            this.beginLoad();
         }
      }
      
      public function get vo() : Vo_grid
      {
         return this._vo;
      }
      
      public function set isAutoLoad(value:Boolean) : void
      {
         this._isAutoLoad = value;
      }
      
      public function beginLoad() : void
      {
         var url:String = null;
         var px:int = 0;
         this.bmp_icon.bitmapData = null;
         this.bmp_iconBg.bitmapData = null;
         if(Boolean(this._vo))
         {
            if(this._vo.id == 500000)
            {
               return;
            }
            if(this.type != Enum_type_grid.TIANMING && this.type != Enum_type_grid.MY_TIAMMING)
            {
               if(this._vo.bgIndex > 0)
               {
                  url = "resource/image/iconBg" + (this._bBigIcon ? "60/" : "/") + this._vo.bgIndex + ".png";
                  if(Boolean(Util.bmdPool[url]))
                  {
                     this.bmp_iconBg.bitmapData = Util.bmdPool[url] as BitmapData;
                  }
                  else
                  {
                     MassLoader.add(url,this.iconBgComp,null,MassLoader.LEVEL2,{"bm":this.bmp_iconBg});
                  }
               }
               else
               {
                  this.bmp_iconBg.bitmapData = null;
               }
            }
            if(this._vo.str_icon == null)
            {
               this.bmp_icon.bitmapData = null;
               this.count = 0;
            }
            else
            {
               url = "resource/image/icon" + (this._bBigIcon ? "60/" : "/") + this._vo.str_icon + this._str_extend_name;
               if(Boolean(Util.bmdPool[url]))
               {
                  this.bmp_icon.bitmapData = Util.bmdPool[url] as BitmapData;
               }
               else
               {
                  MassLoader.add(url,this.iconComp,null,MassLoader.LEVEL2,{"bm":this.bmp_icon});
                  px = this._bBigIcon ? 26 : 16;
                  if(this.type == Enum_type_grid.TIANMING || this.type == Enum_type_grid.MY_TIAMMING)
                  {
                     px += 4;
                  }
                  if(!this.loadEff)
                  {
                     this.loadEff = EffectManager.addEffect("gridloading",this,500,px,px,true,MassLoader.LEVEL1);
                  }
               }
               this.count = this._vo.count;
            }
         }
         else
         {
            this.bmp_icon.bitmapData = null;
            this.bmp_iconBg.bitmapData = null;
            this._count = 0;
            if(Boolean(this.tf_count))
            {
               this.tf_count.visible = false;
            }
         }
         if(Boolean(this.vo))
         {
            if(this.vo is Vo_item)
            {
               if((this.vo as Vo_item).type != 181 && (this.vo as Vo_item).type != 310 && (this.vo as Vo_item).type != 344 && (this.vo as Vo_item).type != 345 && (this.vo as Vo_item).type != 346 && (this.vo as Vo_item).type != 377 && (this.vo as Vo_item).type != 170 && (this.vo as Vo_item).type != 102 && (this.vo as Vo_item).type != 107 && (this.vo as Vo_item).type != 108 && (this.vo as Vo_item).type != 4 && (this.vo as Vo_item).type != 394 && (this.vo as Vo_item).type != 399)
               {
                  if(Boolean(this.tf_info))
                  {
                     this.tf_info.visible = false;
                  }
               }
               else if(Boolean(this.tf_info))
               {
                  setChildIndex(this.tf_info,numChildren - 1);
               }
            }
            else if(Boolean(this.tf_info))
            {
               this.tf_info.visible = false;
            }
         }
         else if(Boolean(this.tf_info))
         {
            this.tf_info.visible = true;
         }
         if(this.type == Enum_type_grid.TIANMING || this.type == Enum_type_grid.MY_TIAMMING)
         {
            this.bmp_icon.x = -13 + EXCURSION_34;
            this.bmp_icon.y = -13 + EXCURSION_34;
         }
         if(!Model_init.isChangeEff)
         {
            return;
         }
         this.resetEff();
         this.gridEffHand();
      }
      
      private function resetEff() : void
      {
         if(Boolean(this.eff175))
         {
            EffectManager.removeEffect(this.eff175);
            this.eff175 = null;
         }
         if(Boolean(this.eff176))
         {
            EffectManager.removeEffect(this.eff176);
            this.eff176 = null;
         }
         if(Boolean(this.eff177))
         {
            EffectManager.removeEffect(this.eff177);
            this.eff177 = null;
         }
      }
      
      private function gridEffHand() : void
      {
         if(!(this.vo is Vo_equip))
         {
            return;
         }
         var _valueVo:Vo_equip = this.vo as Vo_equip;
         if(Boolean(_valueVo))
         {
            if(_valueVo.color >= 5)
            {
               if(!this.eff176)
               {
                  this.eff176 = EffectManager.addEffect("35176",this,1200,17,18,true);
               }
            }
            if(_valueVo.color >= 5 && _valueVo.jingLianCount == _valueVo.maxRefine && _valueVo.jingLianCount > 0)
            {
               if(!this.eff175)
               {
                  this.eff175 = EffectManager.addEffect("35175",this,1200,17,18,true);
               }
            }
         }
      }
      
      private function iconBgComp(info:Object) : void
      {
         if(Boolean(info.content))
         {
            Util.bmdPool[info.url] = (info.content as Bitmap).bitmapData;
         }
         if(this._vo == null)
         {
            return;
         }
         if("resource/image/iconBg" + (this._bBigIcon ? "60/" : "/") + this._vo.bgIndex + ".png" == info.url)
         {
            this.bmp_iconBg.bitmapData = (info.content as Bitmap).bitmapData;
         }
      }
      
      private function iconComp(info:Object) : void
      {
         if(Boolean(this.loadEff))
         {
            EffectManager.removeEffect(this.loadEff);
            this.loadEff = null;
         }
         if(Boolean(info.content))
         {
            Util.bmdPool[info.url] = (info.content as Bitmap).bitmapData;
         }
         if(this._vo == null)
         {
            return;
         }
         if("resource/image/icon" + (this._bBigIcon ? "60/" : "/") + this._vo.str_icon + this._str_extend_name == info.url)
         {
            this.bmp_icon.bitmapData = (info.content as Bitmap).bitmapData;
         }
      }
      
      public function set bBigIcon(value:Boolean) : void
      {
         this._bBigIcon = value;
      }
      
      public function empty() : void
      {
         this.index = 0;
         this.type = 0;
         this.bZero = false;
         this.bOne = false;
         this._bSelect = false;
         this._bMask = false;
         this._count = 0;
         this._vo = null;
         this.set_bmp_bg(null);
         this.set_tf_info("");
         this.set_bmp_over(false);
         this.set_bmp_select(null);
         this.set_tf_count(false);
         this.set_bmp_mask(null);
         this.bmp_iconBg.bitmapData = null;
         this.bmp_icon.bitmapData = null;
      }
      
      private function AddChild(child:DisplayObject, id:int) : void
      {
         this.vec[id] = child;
         var now:int = 0;
         var i:int = 0;
         while(i < this.vec.length)
         {
            if(Boolean(this.vec[i]))
            {
               addChildAt(this.vec[i],now);
               now++;
            }
            i++;
         }
      }
      
      private function setPos_view_tip() : void
      {
         var point:Point = new Point(x,y);
         point = parent.localToGlobal(point);
         if(TipManager.view_equip.visible)
         {
            if(point.x + TipManager.view_tip.width + TipManager.view_equip.width + width > Global.stage.stageWidth)
            {
               TipManager.view_tip.x = point.x - TipManager.view_tip.width;
               TipManager.view_equip.x = TipManager.view_tip.x - TipManager.view_equip.width;
            }
            else
            {
               TipManager.view_tip.x = point.x + this.bmp_bg.width - 2;
               TipManager.view_equip.x = TipManager.view_tip.x + TipManager.view_tip.width;
            }
            if(point.y + TipManager.view_equip.height > Global.stage.stageHeight)
            {
               TipManager.view_equip.y = Global.stage.stageHeight - TipManager.view_equip.height;
            }
            else
            {
               TipManager.view_equip.y = point.y - (Const_png.SIZE_GRID - Const_png.SIZE_ICON) / 2;
            }
            if(point.y + TipManager.view_tip.height > Global.stage.stageHeight)
            {
               TipManager.view_tip.y = Global.stage.stageHeight - TipManager.view_tip.height;
            }
            else
            {
               TipManager.view_tip.y = point.y - (Const_png.SIZE_GRID - Const_png.SIZE_ICON) / 2;
            }
         }
         else
         {
            if(point.x + TipManager.view_tip.width + width > Global.stage.stageWidth)
            {
               TipManager.view_tip.x = point.x - TipManager.view_tip.width;
            }
            else
            {
               this.width;
               this.height;
               if(Boolean(this.bmp_bg) && Boolean(this.bmp_bg.bitmapData))
               {
                  TipManager.view_tip.x = point.x + this.bmp_bg.width - 2;
               }
               else
               {
                  TipManager.view_tip.x = point.x + Const_png.SIZE_ICON + (Const_png.SIZE_GRID - Const_png.SIZE_ICON) / 2;
               }
            }
            if(point.y + TipManager.view_tip.height > Global.stage.stageHeight)
            {
               TipManager.view_tip.y = Global.stage.stageHeight - TipManager.view_tip.height;
            }
            else
            {
               TipManager.view_tip.y = point.y - (Const_png.SIZE_GRID - Const_png.SIZE_ICON) / 2;
            }
         }
      }
      
      private function ROLL_OVER(e:MouseEvent) : void
      {
         if(Boolean(this._vo) && Boolean(this._vo.str_name))
         {
            TipManager.update(this._vo,this.type,this.stoneLvl);
            this.setPos_view_tip();
         }
         if(Boolean(this.bmp_over))
         {
            this.bmp_over.visible = true;
         }
      }
      
      private function ROLL_OUT(e:MouseEvent) : void
      {
         TipManager.hide();
         if(Boolean(this.bmp_over))
         {
            this.bmp_over.visible = false;
         }
      }
   }
}

