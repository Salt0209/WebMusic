using BTL_LWNC_WebAmNhac.Models;
using Microsoft.AspNetCore.Mvc;

namespace BTL_LWNC_WebAmNhac.Services.Interface
{
    public interface IHomeInterface
    {
        List<Playlist> ListPlaylists(int? id);
        List<object> ListRankingPlaylists(int? id);
    }
}
