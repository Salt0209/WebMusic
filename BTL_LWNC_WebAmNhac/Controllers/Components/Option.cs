using Microsoft.AspNetCore.Mvc;

namespace BTL_LWNC_WebAmNhac.Controllers.Components
{
    public class Option : ViewComponent
    {
        public IViewComponentResult Invoke()
        {
            return View();
        }
    }
}
