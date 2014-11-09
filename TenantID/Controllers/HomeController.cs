using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using TenantID.Models;
using TenantID.Models.Entity;

namespace TenantID.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        /// <summary>
        /// Connection String
        /// </summary>
        private DbConnection db = new DbConnection();

        /// <summary>
        /// Open Index form, show user details information
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            List<User> users = new List<User>();
            if (Request.IsAuthenticated)
            {
                using (var db = new DbConnection())
                {
                    string username = User.Identity.Name.Trim().ToLower();
                    var idata = db.Users.Where(c => c.UserName.ToLower().Equals(username));
                    if (idata != null)
                        users = idata.ToList();
                }
            }

            return View(users);
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

            User user = db.Users.Find(id);

            if (user == null)
            {
                return HttpNotFound();
            }

            return View(user);
        }

        /// <summary>
        /// Update User Info
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "TenantID, UserName, DisplayName, Country")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }
    }
}
