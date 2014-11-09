using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace UrlRouting
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Account",
                "Account/{action}/{id}",
                new { controller = "Account", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                                name: "0",
                                url: "{tenantID}",
                                defaults: new { 
                                                tenantID = "{tenantID}", 
                                                controller = "Home", 
                                                action = "Index", 
                                                id = UrlParameter.Optional 
                                              }
                            );

            routes.MapRoute(
                                name: "1",
                                url: "{tenantID}/",
                                defaults: new { 
                                                tenantID = "{tenantID}", 
                                                controller = "Home", 
                                                action = "Index", 
                                                id = UrlParameter.Optional 
                                              }
                            );


            routes.MapRoute(
                                name: "2",
                                url: "{tenantID}/{controller}/",
                                defaults: new { 
                                                tenantID = "{tenantID}", 
                                                controller = "controller", 
                                                action = "Index", 
                                                id = UrlParameter.Optional 
                                              }
                            );


            routes.MapRoute(
                                name: "3",
                                url: "{tenantID}/{controller}/{action}/{id}",
                                defaults: new { 
                                                tenantID = "{tenantID}", 
                                                controller = "controller", 
                                                action = "action", 
                                                id = UrlParameter.Optional 
                                              }
                            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}