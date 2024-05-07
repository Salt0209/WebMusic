using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BTL_LWNC_WebAmNhac.Models
{
    public class PlaylistDetail
    {
        [Key, Column(Order = 0)]
        [ForeignKey("Playlist")]
        public int PlaylistID { get; set; }
        [Key, Column(Order = 1)]
        [ForeignKey("Song")]
        public int SongID { get; set; }

        public Playlist? Playlist { get; set; }

        public Song? Song { get; set; }
    }
}
