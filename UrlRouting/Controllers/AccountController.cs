using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using UrlRouting.Models;
using UrlRouting.Models.Entity;

namespace UrlRouting.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        /// <summary>
        /// ConnectionString to connect Db
        /// </summary>
        private string connectionString = ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString;

        /// <summary>
        /// Open Login Form
        /// </summary>
        /// <param name="returnUrl"></param>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;

            return View();
        }

        /// <summary>
        /// Log user into system and bring him back to his previous place
        /// </summary>
        /// <param name="model"> Log In Model </param>
        /// <param name="returnUrl"> User's Previous Place </param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError("", "The user name or password provided is incorrect.");
                return View(model);
            }
            
            using (var connection = new SqlConnection(connectionString))
            {
                using (var ctx = DatabaseConnection.Create(model.UserName, connection))
                {
                    try
                    {
                        var users = ctx.Users.Where(u => u.Password.Equals(model.Password)).FirstOrDefault();
                        if (users != null && users.UserID != 0)
                        {
                            returnUrl = "~/" + model.UserName + returnUrl;
                            FormsAuthentication.SetAuthCookie(model.UserName, false);
                        }
                    }
                    catch (Exception e)
                    {
                        ModelState.AddModelError("", "The user name or password provided is incorrect.");
                        return View(model);
                    }
                }
            }

            return RedirectToLocal(returnUrl);
        }

        /// <summary>
        /// Open Register Account form
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        /// <summary>
        /// Register Account
        /// </summary>
        /// <param name="model"> Account to registered </param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString))
                {
                    DatabaseConnection.ProvisionTenant(model.UserName, connection);

                    using (var ctx = DatabaseConnection.Create(model.UserName, connection))
                    {
                        ctx.Users.Add(new User
                        {
                            UserName = model.UserName,
                            Password = model.Password,
                            DisplayName = model.DisplayName,
                            Country = model.Country
                        });
                        ctx.SaveChanges();

                        var returnUrl = "~/" + model.UserName + Url.Action("Index", "Home");
                        FormsAuthentication.SetAuthCookie(model.UserName, false);
                        return RedirectToLocal(returnUrl);
                    }
                }
            }

            return View(model);
        }

        /// <summary>
        /// Log off from system
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Login");
        }

        #region Helpers

        /// <summary>
        ///  Redirect to place in local
        /// </summary>
        /// <param name="returnUrl"></param>
        /// <returns></returns>
        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        /// <summary>
        /// Construct Error Message based on Error Code
        /// </summary>
        /// <param name="createStatus"></param>
        /// <returns></returns>
        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "User name already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion
    }
}
