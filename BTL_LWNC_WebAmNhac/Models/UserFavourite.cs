using System.ComponentModel.DataAnnotations;

namespace BTL_LWNC_WebAmNhac.Models
{
    public class UserFavourite
    {
        public UserFavourite() { }

        public UserFavourite(int uid,int pid) { 
            this.UserID = uid;
            this.PlaylistID = pid;
        }
        [Key]
        public int UserID { get; set; }
        [Key]
        public int PlaylistID { get; set; }
    }
}
