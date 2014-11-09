using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using UrlRouting.Models;
using UrlRouting.Models.Entity;

namespace UrlRouting.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        /// <summary>
        /// Connection String
        /// </summary>
        private string connectionString = ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString;

        /// <summary>
        /// Open Index form, show user details information
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            List<User> users = new List<User>();

            using (var connection = new SqlConnection(connectionString))
            {
                using (var ctx = DatabaseConnection.Create(User.Identity.Name, connection))
                {
                    users = ctx.Users.Where(u => u.UserName.Equals(User.Identity.Name)).ToList();
                }
                return View(users);
            }
        }

        /// <summary>
        /// Open Update User Info Form
        /// </summary>
        /// <param name="id"> Id of user </param>
        /// <returns></returns>
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            using (var connection = new SqlConnection(connectionString))
            {
                using (var ctx = DatabaseConnection.Create(User.Identity.Name, connection))
                {
                    var user = ctx.Users.Find(id);
                    if (user == null)
                    {
                        return HttpNotFound();
                    }
                    return View(user);
                }
            }
        }

        /// <summary>
        /// Update User Info
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "UserID, Password, UserName, DisplayName, Country")] User user)
        {
            if (ModelState.IsValid)
            {
                using (var connection = new SqlConnection(connectionString))
                {
                    using (var ctx = DatabaseConnection.Create(user.UserName, connection))
                    {
                        ctx.Entry(user).State = EntityState.Modified;
                        ctx.SaveChanges();
                        return RedirectToAction("Index");
                    }
                }
            }
            return View(user);
        }
    }
}
