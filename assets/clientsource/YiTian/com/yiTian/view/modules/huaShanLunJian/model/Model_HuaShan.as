package com.yiTian.view.modules.huaShanLunJian.model
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.huaShanLunJian.util.Child_HuaShanZhenXingRole;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanReplay;
   
   public class Model_HuaShan
   {
      
      public var tipBtn:BitmapBtn;
      
      public var type:int = 0;
      
      public var matchState:int = 1;
      
      public var isOverMatch:int;
      
      public var myBangType:int;
      
      public var curScore:int;
      
      public var remainLife:int;
      
      public var myCurRank:int;
      
      public var bangType:int = 1;
      
      public var phbPageIndex:int = 1;
      
      public var phbMaxPage:int = 1;
      
      public var teamInfo:Array;
      
      public var myZhuFuInfo:Array;
      
      public var btnBaoMingClickTime:int = -1;
      
      private var _jie:int = 1;
      
      public var bangType2:int = 1;
      
      public var curPlayerInfoArr:Array;
      
      public var curMatchInfoArr:Array;
      
      public var Match32ExtraInfo:Object;
      
      public var countJie:int = 0;
      
      public var currentDragRole:Child_HuaShanZhenXingRole;
      
      private var dragSp:Child_HuaShanZhenXingRole;
      
      public function Model_HuaShan()
      {
         super();
      }
      
      public function get jie() : int
      {
         return this._jie;
      }
      
      public function set jie(v:int) : void
      {
         this._jie = v;
         if(this._jie > this.countJie)
         {
            this.countJie = this._jie;
         }
      }
      
      public function isZFRoleDrag() : Boolean
      {
         return this.currentDragRole != null;
      }
      
      public function set dragRole(role:Child_HuaShanZhenXingRole) : void
      {
         if(Boolean(this.currentDragRole))
         {
            return;
         }
         Tween.stop(this.currentDragRole);
         this.currentDragRole = role;
         this.currentDragRole = role;
      }
      
      public function freeDragRole() : void
      {
         if(Boolean(this.currentDragRole))
         {
            this.currentDragRole = null;
         }
      }
      
      public function findPlayerInfoByID(id:int) : Array
      {
         var arr:Array = null;
         for each(arr in this.curPlayerInfoArr)
         {
            if(arr[0] == id)
            {
               return arr;
            }
         }
         return null;
      }
      
      public function checkPlayerReplay(lun:int, chang:int, nodeData:Object) : void
      {
         var role1InfoArr:Array = null;
         var role2InfoArr:Array = null;
         var id1:Number = Number(nodeData[0]);
         var id2:Number = Number(nodeData[1]);
         role1InfoArr = HuaShanUtil.finPlayerInfoByID(id1,this.curPlayerInfoArr);
         role2InfoArr = HuaShanUtil.finPlayerInfoByID(id2,this.curPlayerInfoArr);
         var bbbb:Boolean = false;
         if(role1InfoArr == null)
         {
            UIManager.centerBroadcast.addMsg("role1的ID为【" + id1 + "】");
            bbbb = true;
         }
         if(role2InfoArr == null)
         {
            UIManager.centerBroadcast.addMsg("role2的ID为【" + id1 + "】");
            bbbb = true;
         }
         if(bbbb)
         {
            return;
         }
         var chakanPnl:View_HuaShanReplay = Singleton.getInstance(View_HuaShanReplay) as View_HuaShanReplay;
         chakanPnl.update(this.jie,this.bangType2,lun,chang,[role1InfoArr,role2InfoArr,nodeData[2]]);
         chakanPnl.visible = true;
      }
   }
}

