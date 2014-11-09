using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UrlRouting.Models.Entity
{
    public class User
    {
        [Key]
        public int UserID { get; set; }

        public string Password { get; set; }

        [Display(Name = "User Name")]
        public string UserName { get; set; }

        [Display(Name = "Display Name")]
        public string DisplayName { get; set; }

        [Display(Name = "Country")]
        public string Country { get; set; }
    }
}