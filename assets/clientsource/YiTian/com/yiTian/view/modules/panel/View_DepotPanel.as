package com.yiTian.view.modules.panel
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.net.message.cg.DepotCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.bag.View_panel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_DepotPanel extends View_panel
   {
      
      private static const COUNT_GRID:int = 36;
      
      private var page_cur:int;
      
      private var page_max:int;
      
      private var vec_View_Grid:Vector.<View_Grid>;
      
      private var vec_Vo_valuable:Vector.<Vo_valuable>;
      
      private var btn_Page_right:Button;
      
      private var btn_Page_left:Button;
      
      private var btn_tidy:Button;
      
      private var tf_page:MyTextField;
      
      private var tf_capacity:MyTextField;
      
      private var btnClose:Button;
      
      private var isFirstOpen:Boolean = true;
      
      private var _now:int;
      
      private var _last:int;
      
      public function View_DepotPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":315,
            "height":390
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":27,
            "y":43,
            "width":261,
            "height":300
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":95,
            "y":309,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":202,
            "y":309,
            "width":54,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60242",6),this,{
            "x":36,
            "y":309,
            "color":11904647,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,290,36);
         this.btn_Page_left = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":180,
            "y":309,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_Page_right = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":257,
            "y":309,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_Page_left.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_LEFT);
         this.btn_Page_right.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_RIGHT);
         this.btn_Page_right.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
         this.btn_Page_left.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
         this.btn_tidy = ComponentUtil.getButton(LangConfig.getWord("864",0),"Button_Four",this,{
            "x":121,
            "y":350,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_tidy.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_TIDY);
         this.btnClose = ComponentUtil.getButton("","Button_Close",this,{
            "x":281,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnClose.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         this.tf_page = ComponentUtil.getTextField("00/00",this,{
            "x":210,
            "y":309,
            "color":12877056,
            "size":12,
            "leading":0,
            "realWidth":38,
            "align":TextAlign.CENTER
         });
         this.tf_capacity = ComponentUtil.getTextField("000/000",this,{
            "x":96,
            "y":309,
            "color":12877056,
            "size":12,
            "leading":0,
            "realWidth":74,
            "align":TextAlign.CENTER
         });
      }
      
      private function overHd(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var btn:Button = e.target as Button;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(dragGrid.type == Enum_type_grid.DEPOT)
            {
               btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
         }
      }
      
      override protected function initDynamicView() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         this.vec_Vo_valuable = new Vector.<Vo_valuable>();
         this.vec_View_Grid = new Vector.<View_Grid>(COUNT_GRID,true);
         i = 0;
         while(i < COUNT_GRID)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.DEPOT;
            grid.set_bmp_over();
            grid.set_tf_count();
            grid.set_bmp_select();
            grid.isAutoLoad = false;
            grid.addEventListener(MouseEvent.MOUSE_UP,this.MOUSE_UP);
            grid.addEventListener(MouseEvent.DOUBLE_CLICK,this.DOUBLE_CLICK);
            grid.doubleClickEnabled = true;
            grid.addEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
            grid.x = 36 + 42 * (i % 6);
            grid.y = 50 + 42 * int(i / 6);
            addChild(grid);
            this.vec_View_Grid[i] = grid;
            i++;
         }
         this.page_cur = 1;
         this.tf_page.text = this.page_cur + "/" + this.page_max;
      }
      
      private function setTitle() : void
      {
         ComponentUtil.getBitmap("Title_Depot",this,{
            "x":88,
            "y":5
         },Global.Bag_Imgsdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
               if(!Global.Bag_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Bag_Imgs.swf",function(info:Object):void
                  {
                     Global.Bag_Imgsdm = info.applicationDomain;
                     setTitle();
                  });
               }
               else
               {
                  this.setTitle();
               }
            }
            if(!UIManager.bagPanel.visible)
            {
               UIManager.bagPanel.visible = true;
            }
            UIManager.bagPanel.resetPosition();
         }
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this.vec_View_Grid.length)
         {
            this.vec_View_Grid[i].isAutoLoad = true;
            this.vec_View_Grid[i].beginLoad();
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 - 300;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function update() : void
      {
         this.vec_Vo_valuable = CommandManager.get_depot_vec();
         this.Show();
      }
      
      private function Show() : void
      {
         var temp:int = 0;
         var vo:Vo_valuable = null;
         var i:int = 0;
         while(i < COUNT_GRID)
         {
            temp = i + (this.page_cur - 1) * COUNT_GRID;
            if(temp < this.vec_Vo_valuable.length && Boolean(this.vec_Vo_valuable[temp]))
            {
               this.vec_View_Grid[i].vo = this.vec_Vo_valuable[temp];
               this.vec_View_Grid[i].set_bmp_bg();
               this.setMouseEvent(this.vec_View_Grid[i],false);
            }
            else
            {
               if(temp + 1 > CommandManager.get_depot_canUse())
               {
                  this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
                  this.setMouseEvent(this.vec_View_Grid[i],true);
               }
               else
               {
                  this.vec_View_Grid[i].set_bmp_bg();
                  this.setMouseEvent(this.vec_View_Grid[i],false);
               }
               vo = new Vo_valuable();
               vo.gridId = temp + 1;
               this.vec_View_Grid[i].vo = vo;
            }
            i++;
         }
         this.tf_capacity.text = CommandManager.get_depot_used() + "/" + CommandManager.get_depot_canUse();
         if(this.vec_Vo_valuable.length < 180)
         {
            this.page_max = this.vec_Vo_valuable.length / COUNT_GRID + 1;
         }
         else
         {
            this.page_max = this.vec_Vo_valuable.length / COUNT_GRID;
         }
         this.tf_page.text = this.page_cur + "/" + this.page_max;
      }
      
      private function setMouseEvent(_view_grid:View_Grid, value:Boolean) : void
      {
         _view_grid.useHandCursor = value;
         _view_grid.buttonMode = value;
         if(value)
         {
            TipManager.bind(_view_grid,LangConfig.getWord("60243",6));
         }
         else
         {
            TipManager.unBind(_view_grid);
         }
         if(value)
         {
            _view_grid.addEventListener(MouseEvent.CLICK,this.openGridHandle);
         }
         else if(_view_grid.hasEventListener(MouseEvent.CLICK))
         {
            _view_grid.removeEventListener(MouseEvent.CLICK,this.openGridHandle);
         }
      }
      
      private function openGridHandle(e:MouseEvent) : void
      {
         View_Alert.show(LangConfig.getWord("878",0),View_Alert.OK_CANCAL,this.okHandle);
      }
      
      private function okHandle() : void
      {
         if(GameUnitManager.hero.money < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("869",0));
            return;
         }
         BagCGMessage.CG_OPEN_BAG_GRID(2);
      }
      
      private function DOUBLE_CLICK(e:MouseEvent) : void
      {
         var grid:View_Grid = e.target as View_Grid;
         if(grid.vo.str_name == null)
         {
            return;
         }
         DepotCGMessage.CG_DEPOT_SWAP(DepotCGMessage.DEPOT_BAG,grid.vo.gridId,0,0);
      }
      
      public function updata_from_bag(_vo:Vo_valuable) : void
      {
         var i:int = 0;
         while(i < this.vec_View_Grid.length)
         {
            if(this.vec_View_Grid[i].vo.id == 0)
            {
               DepotCGMessage.CG_DEPOT_SWAP(DepotCGMessage.BAG_DEPOT,_vo.gridId,this.vec_View_Grid[i].vo.gridId,0);
               return;
            }
            i++;
         }
      }
      
      private function MOUSE_UP(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var upGrid:View_Grid = e.target as View_Grid;
         if(upGrid.vo.gridId > CommandManager.get_depot_canUse())
         {
            return;
         }
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(dragGrid.type == Enum_type_grid.DEPOT)
            {
               if(upGrid != dragGrid)
               {
                  DepotCGMessage.CG_DEPOT_SWAP(DepotCGMessage.DEPOT,dragGrid.vo.gridId,upGrid.vo.gridId,0);
               }
            }
            else if(dragGrid.type == Enum_type_grid.BAG)
            {
               if(upGrid.vo.str_name == null && dragGrid.vo.count > 1)
               {
                  UIManager.num_valuable.Show(dragGrid.vo as Vo_valuable,View_num_valuable.BAG_DEPOT,upGrid.vo.gridId);
               }
               else
               {
                  DepotCGMessage.CG_DEPOT_SWAP(DepotCGMessage.BAG_DEPOT,dragGrid.vo.gridId,upGrid.vo.gridId,0);
               }
            }
         }
      }
      
      private function CLICK_BTN_TIDY(e:MouseEvent) : void
      {
         DepotCGMessage.CG_DEPOT_TIDY();
         this._last = getTimer();
         this.set_btn_tidy(false);
         addEventListener(Event.ENTER_FRAME,this.enabledHanlde);
      }
      
      private function enabledHanlde(e:Event) : void
      {
         this._now = getTimer();
         if(this._now - this._last >= 10000)
         {
            removeEventListener(Event.ENTER_FRAME,this.enabledHanlde);
            this.set_btn_tidy(true);
         }
      }
      
      private function set_btn_tidy(value:Boolean) : void
      {
         this.btn_tidy.enabled = value;
         this.btn_tidy.useHandCursor = value;
         this.btn_tidy.buttonMode = value;
      }
      
      private function CLICK_BTN_RIGHT(e:MouseEvent) : void
      {
         if(this.page_cur < this.page_max)
         {
            ++this.page_cur;
            this.Show();
         }
      }
      
      private function CLICK_BTN_LEFT(e:MouseEvent) : void
      {
         if(this.page_cur > 1)
         {
            --this.page_cur;
            this.Show();
         }
      }
   }
}

