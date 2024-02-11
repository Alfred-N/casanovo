import github

repo = github.Github().get_repo("Noble-Lab/casanovo")

for release in repo.get_releases():
    print(release)
    for release_asset in release.get_assets():
        print(release_asset.name)
        print(release_asset.browser_download_url)
