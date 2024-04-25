using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BTL_LWNC_WebAmNhac.Models
{
    public class Playlist
    {
        [Key]
        public int ID { get; set; }

        [DisplayName("Tên")]
        public string? Name { get; set; }
        [DisplayName("Mô tả")]
        public string? Detail { get; set; }
        [DisplayName("Ảnh bìa")]
        public string? Thumbnail { get; set; }
        [ForeignKey("User")]
        public int UserID { get; set; }
        [ForeignKey("Genre")]
        public int GenreID { get; set; }
        public int? ViewCount { get; set; }

        public virtual User? User { get; set; }
        public virtual Genre? Genre { get; set; }

        public virtual ICollection<PlaylistDetail> PlaylistDetails { get; set; } = new List<PlaylistDetail>();
    }
}
