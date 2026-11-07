package com.yiTian.view.modules.qqPackage
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.YTJSONParser;
   import com.yiTian.view.modules.qqJinQuan.qqJinQuanConfig;
   import flash.external.ExternalInterface;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequestMethod;
   
   public class QQGroupStaticFunctions
   {
      
      public function QQGroupStaticFunctions()
      {
         super();
      }
      
      public static function unBindQQGroup(openId:String, openKey:String, pf:String, pfkey:String, union_id:String, group_openid:String) : void
      {
         var url:String = Util.rep("http://api1.app100621282.twsapp.com/openapi.php?mod=qqgroup&op=unbind&openid={0}&openkey={1}&pf={2}&pfkey={3}&union_id={4}&group_openid={5}",openId,openKey,pf,pfkey,union_id,group_openid);
         qqJinQuanConfig.load(url,handleUnbind,URLLoaderDataFormat.TEXT,URLRequestMethod.POST);
      }
      
      public static function createQQGroup(unionid:String, groupName:String) : void
      {
         if(Global.pf == Enum_SPStr.QZONE)
         {
            ExternalInterface.call("create_qqgroup",unionid,encodeURI(groupName),"create");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("仅QQ空间开放此功能");
         }
      }
      
      public static function addQQGroup(unionid:String, roleName:String, groupOpenId:String) : void
      {
         if(Global.pf == Enum_SPStr.QZONE)
         {
            ExternalInterface.call("addGroup",unionid,encodeURI(roleName),groupOpenId,"join");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("仅QQ空间开放此功能");
         }
      }
      
      public static function handleCreate(ret:Object, unionid:Object, groupopenID:Object) : void
      {
         var unionId:Object = unionid;
         var groupopenid:Object = groupopenID;
         UIManager.centerBroadcast.addMsg("绑定成功");
         BangCGMessage.CG_BANG_QQGROUP_SAVE(unionId.toString(),groupopenid.toString(),1);
         BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(2,GameUnitManager.hero.partyId,unionId.toString());
         BangCGMessage.CG_BANG_PAGE_SEARCH(1,"","",1);
         BangCGMessage.CG_ASK_HANDLE_QQGROUP();
      }
      
      public static function handleUnbind(e:Object) : void
      {
         var json:YTJSONParser = Singleton.getInstance(YTJSONParser);
         var opt:Object = json.parseStringToObject(e.target.data);
         if(0 == opt.ret)
         {
            BangCGMessage.CG_BANG_QQGROUP_SAVE("","",0);
            UIManager.centerBroadcast.addMsg("成功解绑QQ群");
         }
      }
      
      public static function inviteToAddGroup(arr:Array, unionid:String, groupOpenId:String) : void
      {
         if(Global.pf == Enum_SPStr.QZONE)
         {
            ExternalInterface.call("inviteToAddGroup",arr,unionid,groupOpenId,"invite");
            UIManager.centerBroadcast.addMsg("成功邀请帮会成员加入QQ群");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("仅QQ空间开放此功能");
         }
      }
   }
}

